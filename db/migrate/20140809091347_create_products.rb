class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :place
      t.text :elements
      t.integer :price

      t.timestamps
    end
  end
end
