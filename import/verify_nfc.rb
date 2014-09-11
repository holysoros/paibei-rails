items = nil
open('import/dump/verify_nfc.json') do |fp|
    items = JSON.load(fp)
end

items.each do |item|
    r = NfcRecord.find_by nfc_id: item['nfc_id']
    unless r.batch
        puts "NFC not refer to batch: #{r.nfc_id}"
        next
    end
    unless (r.batch.bid == item['bid'] and r.batch.product.id == item['pid'])
        puts "NFC: #{r.nfc_id}"
    end
end
