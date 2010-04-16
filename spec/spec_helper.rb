require 'spec/autorun'

require File.expand_path(File.join(File.dirname(__FILE__),'..','config','env'))

ResultsDir = File.join APP_ROOT, 'tmp', 'results'

FileUtils.rm_rf ResultsDir if File.exists?(ResultsDir)
FileUtils.mkdir_p ResultsDir

def mail_path(name)
  name += '.mail' unless name.ends_with?('.mail')
  File.join APP_ROOT, 'spec', 'fixtures', name
end

def result_path(name)
  name += '.tiff' unless name.ends_with?('.tiff')
  File.join ResultsDir, name
end

def test_configuration
  @@test_configuration ||= Configuration.build({
    'outgoing_call_dir' => ResultsDir,
    'archive_path'      => ResultsDir
  })
end
