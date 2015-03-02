json.array!(@bought_lists) do |bought_list|
  json.extract! bought_list, :id, :total_usd, :raw_order, :buy_list_id, :user_id
  json.url bought_list_url(bought_list, format: :json)
end
