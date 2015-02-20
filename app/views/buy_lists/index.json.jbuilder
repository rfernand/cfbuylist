json.array!(@buy_lists) do |buy_list|
  json.extract! buy_list, :id, :user_id, :requested
  json.url buy_list_url(buy_list, format: :json)
end
