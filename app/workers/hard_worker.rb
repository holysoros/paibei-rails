require 'rqrcode_png'
require 'chunky_png'
require 'tmpdir'
require 'zip/zip_file_generator'

class HardWorker
  include Sidekiq::Worker
  def perform(bid, count, verify_time)
    host = 'http://112.124.117.97/'
    zip_dir = '/usr/share/nginx/html'

    Dir.mktmpdir('qrcode') do |tmpdir|
      logger.info "Doing hard work, #{bid}, #{count} in #{tmpdir}"

      width, height = 800, 800
      icon = ChunkyPNG::Image.from_file('app/assets/images/icon_new.png')
      icon = icon.resize(width / 3, height / 3)

      offset_x = (width - icon.width) / 2
      offset_y = (height - icon.height) / 2

      count.times do |i|
        record = QrcodeRecord.create(batch_id: bid, left_time: verify_time)
        url = host + record.sn
        filepath = File.join(tmpdir, record.sn + '.png')
        generate_qrcode(url, filepath, icon, offset_x, offset_y)
      end
      zip = ZipDir::ZipFileGenerator.new(tmpdir, File.join(zip_dir, bid + '.zip'))
      zip.write
    end
  end

  private
  def generate_qrcode(content, outfile, icon, offset_x, offset_y)
    qr = RQRCode::QRCode.new(content, :size => 5, :level => :q ).to_img
    qr = qr.resize(800, 800)

    qr.compose!(icon, offset_x, offset_y)
    qr.save(outfile, :fast_rgb)
    #qr.save(outfile, :best_compression)
  end
end
