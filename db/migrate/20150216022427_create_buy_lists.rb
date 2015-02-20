class CreateBuyLists < ActiveRecord::Migration
  def change
    create_table :buy_lists do |t|
      t.integer :user_id
      t.boolean :requested

      t.timestamps null: false
    end
  end
end
