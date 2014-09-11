class AddResultToHistories < ActiveRecord::Migration
  def change
    add_column :histories, :result, :string
  end
end
