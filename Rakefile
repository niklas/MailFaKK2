begin  
  require 'rubygems'
  require 'jeweler'  
  Jeweler::Tasks.new do |gemspec|  
    gemspec.name        = %q{mailfakk2}
    gemspec.summary     = %q{email to fax gateway in ruby}
    gemspec.description = %q{
      MailFaKK2 acts as a fax gateway. With the proper setup you can send
      an email to <number>@fax.local and it generates a multipage tiff and
      a callfile for asterisk
    }
    gemspec.email       = %q{niklas+mailfakk2@lanpartei.de}
    gemspec.homepage    = %q{http://github.com/niklas/MailFaKK2/}
    gemspec.authors     = ["Niklas Hofer"]
    gemspec.executables = %w{mailfakk2}

    gemspec.has_rdoc    = false
    gemspec.files       = %w{
      README.mardown
      Rakefile

      bin/mailfakk2

      config/env.rb
      config/forward
      config/procmail

      lib/logging.rb
      lib/configuration.rb
      lib/facsimile.rb
      lib/mailfakk2.rb

      MIT-LICENSE
    }
  end  
  Jeweler::GemcutterTasks.new  
rescue LoadError  
  puts "Jeweler not available. Install it with: sudo gem install jeweler"  
end
