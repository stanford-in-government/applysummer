json.array!(@organizations) do |organization|
  json.extract! organization, :id, :name, :url, :category, :description, :city
  json.url organization_url(organization, format: :json)
end
