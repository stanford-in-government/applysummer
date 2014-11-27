json.array!(@applications) do |application|
  json.extract! application, :id, :category, :status, :rec_code, :user_id
  json.url application_url(application, format: :json)
end
