class AddEditionAndLanguageToBoughCards < ActiveRecord::Migration
  def change
    add_column :bough_cards, :edition, :string
    add_column :bough_cards, :language, :string
  end
end
