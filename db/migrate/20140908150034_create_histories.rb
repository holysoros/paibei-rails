class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.references :product, index: true
      t.references :batch, index: true
      t.integer :dist_place
      t.string :client_ip
      t.string :type
      t.references :qrcode_record, index: true
      t.references :nfc_record, index: true

      t.timestamps
    end
  end
end
