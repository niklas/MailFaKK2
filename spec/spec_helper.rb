require 'spec/autorun'

require File.expand_path(File.join(File.dirname(__FILE__),'..','config','env'))

ResultsDir = File.join APP_ROOT, 'tmp', 'results'

Spec::Runner.configure do |config|
  config.before(:each) do
    FileUtils.mkdir_p ResultsDir
  end
end

def mail_path(name)
  name += '.mail' unless name.ends_with?('.mail')
  File.join APP_ROOT, 'spec', 'fixtures', name
end

def result_path(name)
  name += '.tiff' unless name.ends_with?('.tiff')
  File.join ResultsDir, name
end
