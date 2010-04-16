require 'spec_helper'

describe "MailFakk2 delivery" do
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
  it 'maybe should detach from procmail to enhance processing speed'
  it 'should save the tiff to the archive path'
  it 'should create and move a callfile with proper permissions'
  it 'should wait for the callfile to be moved to outgoing_done'
  it 'should deliver a mail if no number was found'
  it 'should deliver a mail if sending the fax failed'
end
