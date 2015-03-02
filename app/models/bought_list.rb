class BoughtList < ActiveRecord::Base
  belongs_to :buy_list
  belongs_to :user

  def parse_raw_order
    raw_order.split("\r\n").each_slice(2) do |card_info|
      #todo
      #card_info
    
    end
  end
end
