class Facsimile

  #include ActiveSupport::Memoization

  class NoPhoneNumberFound < Exception; end

  attr_reader :source_path
  attr_reader :frames
  attr_reader :mail

  def initialize(source_path)
    @source_path = source_path
    @frames = []
    @mail = Mail.read source_path
  end

  def number
    n = mail.header['X-Original-To'].andand.to_s || mail.to.first
    if n.to_s =~ /^(\d{5,})/
      return $1
    else
      raise NoPhoneNumberFound, "could not find any phone number"
    end
  end
  
  #memoize :number

  def render

    if mail.multipart?
      mail.parts.each do |part|
        frames << part
      end
    end

  end

end
