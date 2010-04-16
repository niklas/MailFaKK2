class MailFakk2
  def self.deliver(source)
    new(source).deliver
  end

  attr_reader :fax

  def initialize(source)
    @fax = Facsimile.new(source)
  end

  def deliver
    self
  end

  def config
    @config ||= Configuration.load
  end
end
