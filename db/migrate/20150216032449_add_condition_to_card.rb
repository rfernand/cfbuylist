class AddConditionToCard < ActiveRecord::Migration
  def change
    add_column :cards, :condition, :string
  end
end
