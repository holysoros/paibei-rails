require 'rqrcode_png'
require 'chunky_png'
require 'tmpdir'
require 'zip/zip_file_generator'

class HardWorker
  include Sidekiq::Worker
  def perform(batch_id, batch_bid, product_id)
    host = 'http://112.124.117.97/'
    if product_id == 5
      host = 'http://112.124.117.97/m/'
    end
    zip_dir = '/usr/share/nginx/html/'
	
	Dir.mktmpdir('qrcode') do |tmpdir|
      file_name = tmpdir + "/" + batch_bid + ".txt"
      batch = Batch.find(batch_id)
	  
      File.open(file_name, "a+"){|file|
        batch.count.times do |i|
          record = batch.qrcode_records.create(index: i, left_time: batch.verify_time)
          url = host + record.sn + ","
          file.puts(url)
        end
        file.close
      }	  
	  
      zipfilepath = File.join(zip_dir, batch.bid + '.zip')
      zip = ZipDir::ZipFileGenerator.new(tmpdir, zipfilepath)
      zip.write
      File.chmod(0644, zipfilepath)
    end
  end

  private
  def generate_qrcode(content, outfile, icon, offset_x, offset_y)
    qr = RQRCode::QRCode.new(content, :size => 5, :level => :q ).to_img
    qr = qr.resize(406, 406)

    qr.compose!(icon, offset_x, offset_y)
    qr.save(outfile, :fast_rgb)
    #qr.save(outfile, :best_compression)
  end
end