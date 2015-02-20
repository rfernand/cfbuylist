class AddDolarToBuyList < ActiveRecord::Migration
  def change
    add_column :buy_lists, :dolar, :float
  end
end
