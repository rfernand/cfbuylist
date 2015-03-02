json.array!(@bought_cards) do |bought_card|
  json.extract! bought_card, :id, :card_id, :usd_price, :user_id, :condition, :quantity, :bought_list_id
  json.url bought_card_url(bought_card, format: :json)
end
