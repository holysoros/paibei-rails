items = nil
open('import/dump/verify_qrcode.json') do |fp|
    items = JSON.load(fp)
end

items.each do |item|
    r = QrcodeRecord.find_by sn: item['sn']
    unless (r.batch.bid == item['bid'] and r.batch.product.id == item['pid'])
        fail
    end
end
