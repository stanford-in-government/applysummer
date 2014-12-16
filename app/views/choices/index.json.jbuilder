json.array!(@choices) do |choice|
  json.extract! choice, :id, :rank, :statement, :budget, :at_home, :organization_id, :application_id
  json.url choice_url(choice, format: :json)
end
