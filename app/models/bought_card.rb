class BoughtCard < ActiveRecord::Base
  belongs_to :card
  belongs_to :user
  belongs_to :bought_list
end
