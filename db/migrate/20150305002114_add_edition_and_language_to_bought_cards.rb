class AddEditionAndLanguageToBoughtCards < ActiveRecord::Migration
  def change
    add_column :bought_cards, :edition, :string
    add_column :bought_cards, :language, :string
  end
end
