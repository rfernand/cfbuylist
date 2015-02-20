class Card < ActiveRecord::Base
  belongs_to :buy_list
  belongs_to :user
end
