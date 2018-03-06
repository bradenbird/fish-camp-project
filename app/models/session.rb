class Session < ApplicationRecord
  has_many :session_availabilities
  has_many :applicants, through: :session_availabilities
  has_many :camps
  has_many :chairs, through: :camps 
end
