class BoughtList < ActiveRecord::Base
  belongs_to :buy_list
  belongs_to :user
  has_many :bought_cards
  has_many :cards, through: :bought_cards

  def parse_raw_order
    # Parse Channelfireball checkout information in the format:
    # - 8x Bloodsoaked Champion, Khans of Tarkir\n   Condition: NM-Mint | Language: English, $11.92\n 
    # - 1x Mountain (242) - Zendikar Full Art (Lot of 20), «Wholesale Lots» Condition: Slightly Played, $17.99 
    
    #raw_order.split("\n").each_slice(2) do |card_info|
    raw_order.split((/\n\W-/)).each do |card_info|
      #todo
      basic_info = card_info.split(/\WCondition:\W/)[0].split(",")
      quantity = basic_info[0].slice!(/\W\d+x /).try(:scan, /\d/).join().try(:to_i)


      edition = basic_info.pop.try(:strip)
      card_name = basic_info.join(", ")

      more_info = card_info.split(/\WCondition:\W/)[1]
      if more_info.include? "|"
        # includes language
        raw_condition, raw_language_and_price  = more_info.split("|")
        raw_language, raw_price = raw_language_and_price.split(",")
      else
        # does not include language
        raw_condition, raw_price  = more_info.split(",")
      end

      condition = raw_condition.try(:strip)
      language = raw_language.gsub("Language:", "").try(:strip) if raw_language
      price = raw_price.gsub("$", "").try(:strip).try(:to_d)

      card = Card.find_by_name_and_buy_list_id(card_name, self.buy_list_id) || Card.create(
            name: card_name,
            condition: condition,
            quantity: quantity,
            price: (price/quantity).to_f,
            user: nil,
            buy_list_id: self.buy_list_id)

      #card_info
      BoughtCard.create(user:  card.user,
                        card: card,
                        condition: condition,
                        quantity: quantity,
                        edition: edition,
                        language: language,
                        usd_price: price/quantity,
                        bought_list: self)
    end
  end

  def count_all_cards
    bought_cards.map{|bought_card| bought_card.quantity}.reduce(:+)
  end

  def calculate_total_usd
    bought_cards.map{|bought_card| bought_card.total_usd}.reduce(:+).to_f
  end
end
