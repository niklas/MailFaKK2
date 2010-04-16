class MailFakk2
  def self.deliver(source)
    new(source).deliver
  end

  attr_reader :fax

  def initialize(source)
    @fax = Facsimile.new(source)
  end

  def deliver!
    @fax.write( archive_path )
    self
  end

  def archive_path
    File.join( config.archive_path, @fax.filename)
  end

  def config
    @config ||= Configuration.load
  end
end
