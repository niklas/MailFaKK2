class Facsimile
  include Logging

  Width = 1728
  Height = 2156

  #include ActiveSupport::Memoization

  class Error < ::Exception; end
  class NoPhoneNumberFound < Error; end
  class NoContentFound < Error; end
  class BadContent < Error; end

  attr_reader :frames
  attr_reader :mail

  def initialize(source)
    if source.is_a?(IO)
      @mail = Mail.new(source.read)
    else
      @mail = Mail.read(source)
    end
    @frames = Magick::ImageList.new
    @tempfiles = []
  end

  def number
    n = mail.header['X-Original-To'].andand.to_s || mail.to.andand.first
    if n.present? && n.to_s =~ /^(\d{5,})/
      return $1
    else
      raise NoPhoneNumberFound, "could not find any phone number"
    end
  end
  
  #memoize :number

  def render

    if mail.multipart?

      mail.parts.each do |part|
        case part.content_type
        when %r'text/plain'
          add_frames text2tiff( part.decoded )
        when %r'opendocument\.text'
          add_frames oo2tiff( part.decoded )
        when %r'openxmlformats-officedocument' # docx, xlsx
          add_frames oo2tiff( part.decoded, part.filename )
        when %r'application/pdf'
          add_frames pdfdata2tiff( part.decoded )
        when %r'text/html'
          # FIXME ignore html, let's hope a plain text contained everything important
        when %r'multipart/alternative'
          # ignore this, stupid outlook
        else
          log "unsupported content type: #{part.content_type}"
        end
      end

    else

      unless mail.body.decoded.blank?
        text2tiff( mail.body.decoded ).each do |tiff|
          frames << tiff
        end
      end

    end

  end

  def write(path)
    render
    raise NoContentFound if frames.empty?
    path = File.expand_path path
    log("writing facsimile to #{path}")
    path += '.tiff' unless path.ends_with?('.tiff')
    dir = File.dirname path
    FileUtils.mkdir_p(dir) unless File.directory?(dir)
    frames.write(path)
  end

  def filename
    "#{id}.tiff"
  end

  def callfile_name
    "#{id}.call"
  end

  def id
    unless mail.has_message_id?
      mail.add_message_id("#{Time.now.iso8601}-#{Process.pid}")
    end
    mail.message_id
  end

  private

  def add_frames(tiffs=nil)
    return unless tiffs
    tiffs.each do |tiff|
      frames << tiff
    end
  end

  def text2tiff(text)
    pdf = text2pdf(text)
    pdf2tiff(pdf)
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
    read_frame dest.path
  end

  def pdfdata2tiff(source_data)
    pdf = mktemp('pdf')
    File.open pdf.path, 'w' do |f|
      f.puts source_data
    end
    pdf2tiff(pdf.path)
  end

  # For some filetypes we need the filename to apend the same extention to the tempfile
  def oo2tiff(source_data, filename=nil)
    if filename.blank?
      source = mktemp('oo', false)
      pdf_path = source.path + '.pdf'
    else
      extention = filename.split('.').last
      source = mktemp(['oo', ".#{extention}"], false)
      pdf_path = source.path.sub(/#{extention}$/,'pdf')
    end
    source.write source_data
    source.close

    dest = mktemp('pdf')
    xvfb("unoconv -f pdf #{source.path}")
    if File.file?(pdf_path)
      FileUtils.mv pdf_path, dest.path
      pdf2tiff(dest.path)
    end
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

  def mktemp(name,close=true)
    tmp = Tempfile.new(name)
    tmp.close if close
    tmp
  end

  def pagesize
    'a4'
  end

  def xvfb(command)
    system("xvfb-run --auto-servernum --server-num=23 #{command}")
  end


end
