class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :place
      t.text :elements
      t.string :image
      t.integer :price
      t.integer :index

      t.timestamps
    end
  end
end
