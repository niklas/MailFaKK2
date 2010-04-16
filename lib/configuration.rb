require 'ostruct'
class Configuration < OpenStruct
  Defaults = {
    'outgoing_call_dir' => '/var/spool/asterisk/outgoing'
  }

  # Config files are read in this order
  Sources = [
    '/etc/mailfakk2.yml',
    File.join( ENV['HOME'], '.mailfakk2.yml')
  ]

  def self.load
    conf = returning(Defaults) do |h|
      Sources.each do |source|

        if File.file?(source) && File.readable?(source)
          loaded = YAML.load_file source
          if loaded.is_a?(Hash)
            h.merge! loaded
          end
        end

      end
    end
    new conf
  end
end
