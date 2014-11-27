json.array!(@profiles) do |profile|
  json.extract! profile, :id, :user_id, :first_name, :middle_name, :last_name, :local_street, :local_city, :local_state, :local_postal, :perm_street, :perm_city, :perm_state, :perm_postal, :majors, :minors, :class_year, :overall_gpa, :major_gpa
  json.url profile_url(profile, format: :json)
end
