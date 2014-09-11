require 'active_record'
require 'sqlite3'
require 'json'
require 'byebug'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3', # or 'postgresql' or 'sqlite3'
  database: '../db/development.sqlite3',
)

# Note that the corresponding table is 'orders'
class Batch < ActiveRecord::Base
end

class QrcodeRecord < ActiveRecord::Base
end

class Product < ActiveRecord::Base
end

items = nil
open(ARGV[0]) do |fp|
    items = JSON.load(fp)
end

items.each do |item|
    r = QrcodeRecord.find_by sn: item['sn']
    unless (r.batch.bid == item['bid'] and r.batch.product.id == item['pid'])
        fail
    end
end
