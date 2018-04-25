class Evaluation < ApplicationRecord
  belongs_to :chair
  belongs_to :applicant

  validates :chair_id, presence: true
  validates :applicant_id, presence: true
end
