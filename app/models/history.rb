class History < ActiveRecord::Base
  belongs_to :product
  belongs_to :batch
  belongs_to :qrcode_record
  belongs_to :nfc_record
end
