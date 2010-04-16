require 'ostruct'
class Configuration < Hash
  Defaults = {
    'outgoing_call_dir' => '/var/spool/asterisk/outgoing',
    'archive_path'      => File.join(ENV['HOME'], 'facsimiles')
  }

  # Config files are read in this order
  Sources = [
    '/etc/mailfakk2.yml',
    File.join( ENV['HOME'], '.mailfakk2.yml')
  ]

  def method_missing(methname, *args, &block)
    methname = methname.to_s
    if has_key?(methname)
      self[methname]
    else
      if !block_given? && args.empty?
        raise NoMethodError, "unknown configuration field: #{methname}"
      else
        super
      end
    end
  end

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
    build conf
  end

  def self.default
    build Defaults
  end

  def self.build(hash)
    new.update(hash)
  end
end
