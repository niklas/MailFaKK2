class MailFakk2
  def self.deliver!(source)
    new(source).deliver!
  end

  attr_reader :fax

  def initialize(source)
    @fax = Facsimile.new(source)
  end

  def deliver!
    @fax.write( archive_path )
    write_callfile
    self
  end

  def archive_path
    File.expand_path File.join( config.archive_path, @fax.filename)
  end

  def callfile_path
    File.join( config.outgoing_call_dir, @fax.callfile_name)
  end

  def config
    @config ||= Configuration.load
  end

  def write_callfile
    tmp = Tempfile.new('call')
    tmp.puts callfile_contents
    tmp.close
    FileUtils.mkdir_p config.outgoing_call_dir
    FileUtils.mv tmp.path, callfile_path
    FileUtils.chmod 0666, callfile_path
  end

  def callfile_contents
    <<-EOCALL
Channel: DAHDI/g0/#{@fax.number}
MaxRetries: 5
WaitTime: 20
Context: incoming-fax
Application: SendFax
Data:#{archive_path}
Archive: yes
    EOCALL
  end
end
