json.array!(@cards) do |card|
  json.extract! card, :id, :name, :price, :link, :user_id
  json.url card_url(card, format: :json)
end
