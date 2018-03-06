class Applicant < ApplicationRecord
  has_many :session_availabilities
  has_many :sessions, through: :session_availabilities
end
