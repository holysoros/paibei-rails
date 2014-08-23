class CreateNfcRecords < ActiveRecord::Migration
  def change
    create_table :nfc_records do |t|
      t.string :nfc_id
      t.references :batch, index: true

      t.timestamps
    end
  end
end
