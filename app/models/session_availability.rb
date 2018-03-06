class SessionAvailability < ApplicationRecord
  belongs_to :applicant
  belongs_to :session
end
