class BuyList < ActiveRecord::Base
  has_many :cards
  belongs_to :user

  validates :dolar, presence: true
end
