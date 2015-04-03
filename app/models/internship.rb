class Internship < ActiveRecord::Base
  belongs_to :application

  validates :name, :city, :country, :supervisor_name, :supervisor_title,
  :supervisor_email, :supervisor_phone, :faculty_name, :category,
  :related_to, :work_scope, :reason, presence: true

  SURVEY_LABELS = {
    financial_aid: 'Are you a financial aid recipient?',
    at_home: 'Are you planning on living at home during the internship?'
  }

  CHECK_LIST_LABELS = {
    unpaid: 'The internship is unpaid.',
    minimum_length: 'The internship is at least nine weeks long.',
    fulltime: 'The internship is full-time (at least 35 hours weekly).',
    travel_warning: 'The US State Department has NOT issued a travel warning for the country in which the internship is located.',
    political: 'The internship is NOT with a political campaign or partisan organization.',
    social_service: 'The internship is NOT in direct social services (such as tutoring, medical services, recreational services, community improvement services).'
  }

  SHORT_ANSWER_QUESTIONS = {
    work_scope: 'Describe the specific work scope and tasks in your 9-week internship. What is the role of the office in policymaking? How will your internship relate to public policy (government functions related to policy-making, research related to public policy or government, implementation or development of policy)? (200 words max)',
    # relevance: 'Describe how your internship is, by nature, in public policy, as defined above (government functions related to policy-making, research related to public policy or government, implementation or development of policy). (100 words max)',
    reason: 'What financial considerations would you like us to know about? What are your plans in case you do not receive a stipend? (100 words max)',
    budget: 'Please estimate your budget (i.e. housing, transporation, food, etc.)'
  }

  CATEGORIES = [
    'a government organization',
    'a think tank',
    'a non-profit organization',
    'a media organization focused on public policy or politics',
  ]

  RELATED_TO = [
    'government functions related to policy-making',
    'research related to politics, public policy, or government, but it involves the application of research into public policy',
    'implementation or development of policy',
  ]

  def supervisor
    "#{supervisor_name}
    #{supervisor_title}
    #{supervisor_email}
    #{supervisor_phone}"
  end

  def location
    "#{city}
    #{Country[country]}"
  end
end
