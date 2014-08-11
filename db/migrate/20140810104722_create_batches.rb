class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.references :product, index: true
      t.integer :dist_place
      t.integer :count
      t.integer :verify_time
      t.string :bid

      t.timestamps
    end
  end
end
