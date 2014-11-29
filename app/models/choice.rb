class Choice < ActiveRecord::Base
  belongs_to :organization
  belongs_to :application

  alias_attribute :fellowship, :organization
end
