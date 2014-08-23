class AddIndexToQrcodeRecord < ActiveRecord::Migration
  def change
    add_column :qrcode_records, :index, :integer
  end
end
