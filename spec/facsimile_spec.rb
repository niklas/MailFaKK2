require 'spec_helper'

describe "text only" do
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

describe "multipart from word mail client" do
  before(:each) do
    @mail_path = mail_path('multipart')
    @fax = Facsimile.new @mail_path
  end

  it 'should find #number' do
    @fax.number.should == '01189998819991197253'
  end

  it 'should render 1 frame from parts' do
    @fax.write result_path('multipart')
    @fax.frames.should be_an(Magick::ImageList)
    @fax.should have(1).frame
  end
end
