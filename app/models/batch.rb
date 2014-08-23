class Batch < ActiveRecord::Base
  belongs_to :product
  has_many :qrcode_records, dependent: :destroy
  has_many :nfc_records, dependent: :destroy

  before_create :get_bid

  protected
    def get_bid
      ts = Time.now.strftime("%y%m%d")
      format = '%s-%02d-%02d'
      self.bid = format % [ts, product.id, dist_place]
    end
end
