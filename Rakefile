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

    gemspec.add_dependency('activesupport', '>=2.3.5')
    gemspec.add_dependency('andand', '>=1.3.1')
    gemspec.add_dependency('mail', '>=2.2.0')
    gemspec.add_dependency('prawn', '>=0.8.4')
  end  
  Jeweler::GemcutterTasks.new  
rescue LoadError  
  puts "Jeweler not available. Install it with: sudo gem install jeweler"  
end
