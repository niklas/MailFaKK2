require 'spec/autorun'

require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
ResultsDir = File.join APP_ROOT, 'tmp', 'results'

Spec::Runner.configure do |config|
  config.before(:each) do
    FileUtils.mkdir_p ResultsDir
  end
end
