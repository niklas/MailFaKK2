class Facsimile

  Width = 1728
  Height = 2156

  #include ActiveSupport::Memoization

  class NoPhoneNumberFound < Exception; end

  attr_reader :source_path
  attr_reader :frames
  attr_reader :mail

  def initialize(source_path)
    @source_path = source_path
    @frames = Magick::ImageList.new
    @mail = Mail.read source_path
    @tempfiles = []
  end

  def number
    n = mail.header['X-Original-To'].andand.to_s || mail.to.first
    if n.to_s =~ /^(\d{5,})/
      return $1
    else
      raise NoPhoneNumberFound, "could not find any phone number"
    end
  end
  
  #memoize :number

  def render

    unless mail.body.blank?
      text2tiff( mail.body.encoded ).each do |tiff|
        frames << tiff
      end
    end

    if mail.multipart?
      mail.parts.each do |part|
        STDERR.puts "TODO evaluate parts"
      end
    end

  end

  private

  def text2tiff(text)
    pdf = text2pdf(text)
    read_frame pdf2tiff(pdf)
  end

  def pdf2tiff(source)
    dest = mktemp('tiff')
    command = returning ['gs'] do |gs|
      gs << '-dQUIET'
      gs << '-sDEVICE=tiffg3'
      gs << "-sPAPERSIZE=#{pagesize}"
      gs << '-r204x196'
      gs << '-dNOPAUSE'
      gs << "-sOutputFile=#{dest.path}"
      gs << '-c save pop'
      gs << '-c "<< /Policies << /PageSize 5 >> /PageSize [595 842] /InputAttributes << 0 << /PageSize [595 842] >> >> >> setpagedevice"'
      gs << "-f #{source}"
      gs << '-c quit'
    end.join(' ')
    system(command)
    dest.path
  end

  def text2pdf(source)
    document = Prawn::Document.new(:page_size => pagesize.upcase)
    document.text source

    dest = mktemp('pdf')
    document.render_file dest.path
    
    dest.path
  end

  def new_frame
    tiff = Magick::Image.new(Width, Height) do
      self.background_color = 'white'
    end
    tiff
  end

  def read_frame(source)
    Magick::Image.read(source)
  end

  def mktemp(name)
    tmp = Tempfile.new(name)
    tmp.close
    tmp
  end

  def pagesize
    'a4'
  end


end
