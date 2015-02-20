class AddOrderDateToBuyList < ActiveRecord::Migration
  def change
    add_column :buy_lists, :order_date, :date
  end
end
