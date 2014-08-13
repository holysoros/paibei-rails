class CreateQrcodeRecords < ActiveRecord::Migration
  def change
    create_table :qrcode_records do |t|
      t.references :batch, index: true
      t.string :sn
      t.integer :left_time

      t.timestamps
    end
    add_index :qrcode_records, :sn, unique: true
  end
end
