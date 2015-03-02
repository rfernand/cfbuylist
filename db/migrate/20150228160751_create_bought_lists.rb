class CreateBoughtLists < ActiveRecord::Migration
  def change
    create_table :bought_lists do |t|
      t.decimal :total_usd
      t.text :raw_order
      t.references :buy_list, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :bought_lists, :buy_lists
    add_foreign_key :bought_lists, :users
  end
end
