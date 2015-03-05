class BoughtList < ActiveRecord::Base
  belongs_to :buy_list
  belongs_to :user

  def parse_raw_order
    raw_order.split("\n").each_slice(2) do |card_info|
      # - 8x Bloodsoaked Champion, Khans of Tarkir\n   Condition: NM-Mint | Language: English, $11.92\n 
      #todo
      quantity = card_info[0].slice(/^[\W][-][\W]\dx /).try(:scan, /\d/).try(:first).try(:to_i)

      basic_info = card_info[0].split(",")

      edition = basic_info.pop.try(:strip)
      card_name = basic_info.join(", ")

      more_info = card_info[1].split("|")
      condition = more_info[0].gsub("Condition:", "").try(:strip)
      language = more_info[1].split(",")[0].gsub("Language:", "").try(:strip)
      price = more_info[1].split(",")[1].gsub("$", "").try(:strip).try(:to_d)

      card = Card.find_by_name_and_bought_list_id(card_name, self.bought_list_id) || Card.create(
            name: card_name,
            condition: condition,
            quantity: quantity,
            price: price.to_f,
            user: nil,
            buy_list: self.buy_list)

      #card_info
      BoughtCard.create(user:  card.user,
                        card: card,
                        condition: condition,
                        quantity: quantity,
                        edition: edition,
                        language: language,
                        usd_price: price,
                        bough_list: self)
    end
  end
end
