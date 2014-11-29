json.array!(@recommendations) do |recommendation|
  json.extract! recommendation, :id, :email, :name, :application_id, :text
  json.url recommendation_url(recommendation, format: :json)
end
