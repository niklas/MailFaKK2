require 'spec_helper'

describe "MailFakk2" do
  before(:each) do
    @mail = mail_path('only_text')
    @fakk = MailFakk2.new @mail
  end

  it 'should create a Facsimile' do
    @fakk.fax.should be_a(Facsimile)
  end

  it 'should load configuration' do
    Configuration.should_receive(:load).once.and_return('config')
    @fakk.config.should == 'config'
  end

  describe "delivery" do

    before(:each) do
      @conf = test_configuration
      @fax_path = File.expand_path File.join( @conf.archive_path, @fakk.fax.filename)
      @fakk.stub!(:config).and_return(@conf)
      @fax = @fakk.fax
      @fax.stub!(:render)
      frames_mock = mock(:empty? => false, :write => true)
      @fakk.fax.stub!(:frames).and_return(frames_mock)
      @delivering = lambda { @fakk.deliver! }
    end

    after(:each) do
    end

    it 'should render the fax' do
      @fax.should_receive(:render).once
      @delivering.call
    end

    it 'should save the tiff to the archive path' do
      @fax.should_receive(:write).with( @fax_path )
      @delivering.call
    end

    it 'should create and move a callfile with proper permissions' do
      @delivering.call
      callfile_path = File.join( @conf.outgoing_call_dir, @fax.callfile_name)
      File.file?(callfile_path).should be_true
      # TODO permissions should be 0666, just to be sure. How to test this?
    end

    it 'should wait for the callfile to be moved to outgoing_done'
    it 'should deliver a mail if no number was found'
    it 'should deliver a mail if sending the fax failed'
    it 'may deliver a mail report for successfull delivery'
  end
  it 'maybe should detach from procmail to enhance processing speed'
end
