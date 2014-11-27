json.array!(@choices) do |choice|
  json.extract! choice, :id, :rank, :statement, :organization_id, :application_id
  json.url choice_url(choice, format: :json)
end
