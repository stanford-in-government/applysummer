json.array!(@organizations) do |organization|
  json.extract! organization, :id, :name, :url, :category, :description, :city, :state
  json.url organization_url(organization, format: :json)
end
