json.array!(@documents) do |document|
  json.extract! document, :id, :category, :user_id
  json.url document_url(document, format: :json)
end
