require 'spec_helper'

describe "mime with text only" do
  before(:each) do
    @mail_path = mail_path('mime_only_text')
    @fax = Facsimile.new @mail_path
  end

  it 'should find #number' do
    @fax.number.should == '01189998819991197253'
  end
  
end
