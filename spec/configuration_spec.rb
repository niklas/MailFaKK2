require 'spec_helper'

describe Configuration do
  describe "loading" do
    it 'should try system, then home' do
      File.should_receive(:file?).ordered.with('/etc/mailfakk2.yml').and_return(false)
      File.should_receive(:file?).ordered.with( File.join(ENV['HOME'], '.mailfakk2.yml') ).and_return(false)
      c = Configuration.load
      c.should be_a(Configuration)
    end

    it 'should fall back to defaults' do
      File.stub!(:file?).and_return(false)
      c = Configuration.load
      Configuration::Defaults.each do |k,v|
        c.send(k).should == v
      end
    end
  end
end
