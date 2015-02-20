class AddStockToCard < ActiveRecord::Migration
  def change
    add_column :cards, :stock, :integer
  end
end
