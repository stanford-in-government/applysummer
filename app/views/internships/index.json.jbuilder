json.array!(@internships) do |internship|
  json.extract! internship, :id, :application_id, :name, :city, :country, :supervisor_name, :supervisor_title, :supervisor_email, :supervisor_phone, :faculty_name, :financial_aid, :unpaid, :minimum_length, :fulltime, :travel_warning, :political, :social_service, :category, :related_to, :work_scope, :relevance, :reason
  json.url internship_url(internship, format: :json)
end
