class CreateBoughtCards < ActiveRecord::Migration
  def change
    create_table :bought_cards do |t|
      t.references :card, index: true
      t.decimal :usd_price
      t.references :user, index: true
      t.string :condition
      t.integer :quantity
      t.references :bought_list, index: true

      t.timestamps null: false
    end
    add_foreign_key :bought_cards, :cards
    add_foreign_key :bought_cards, :users
    add_foreign_key :bought_cards, :bought_lists
  end
end
