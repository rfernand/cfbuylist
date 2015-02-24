class UpdatePrices
  @queue = :update_prices

  def self.perform(buy_list)
    require 'nokogiri'
    require 'open-uri'

    cards = buy_list.cards

    cards.each do |card|
      doc = Nokogiri::HTML(open(card.link))

      if doc.css('h2.product-heading')[2].text != 'Currently Out Of Stock'
        card.condition = doc.at_css('table.prod-variants .even td').text
        card.price = doc.at_css('table.prod-variants .even td .price').text[/[0-9\.]+/]
        card.stock = doc.at_css('table.prod-variants .even td .qty').text[/[0-9\.]+/]
      else
        card.stock = nil
        card.price = 0
        card.condition = nil
      end

      card.save
    end
  end
end
