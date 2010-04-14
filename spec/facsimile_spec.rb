require 'spec_helper'

describe "mime with text only" do
  before(:each) do
    @mail_path = mail_path('only_text')
    @fax = Facsimile.new @mail_path
  end

  it 'should find #number' do
    @fax.number.should == '01189998819991197253'
  end

  it 'should render 1 frame from body' do
    @fax.write result_path('only_text')
    @fax.frames.should be_an(Magick::ImageList)
    @fax.should have(1).frame
  end
  
end
