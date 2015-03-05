class Card < ActiveRecord::Base
  belongs_to :buy_list
  belongs_to :user
  has_many :bought_cards, dependent: :destroy
end
