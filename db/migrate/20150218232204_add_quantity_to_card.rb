class AddQuantityToCard < ActiveRecord::Migration
  def change
    add_column :cards, :quantity, :integer
  end
end
