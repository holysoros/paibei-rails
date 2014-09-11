NfcRecord.all.each do |r|
    records = NfcRecord.where nfc_id: r.nfc_id
    if records.count > 1
        batches = []
        records.each do |record|
            batches << record.batch.bid 
        end
        puts "#{r.nfc_id}: #{batches.join(' ')}"
    end
end
