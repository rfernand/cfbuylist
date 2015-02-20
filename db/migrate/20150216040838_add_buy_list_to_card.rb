class AddBuyListToCard < ActiveRecord::Migration
  def change
    add_column :cards, :buy_list_id, :integer
  end
end
