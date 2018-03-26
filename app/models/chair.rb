class Chair < ApplicationRecord
  belongs_to :camp
  belongs_to :user

  has_many :evaluations
  has_many :evaluated_applicants,
           through: :evaluations,
           source: :applicant

  # This is just something to grab all "good" applicants that a Chair has
  # evaluated: rating system isn't set in stone. This is just an early example
  has_many :good_applicants,
           ->() { where(rating: "A") },
           source: :applicant,
           through: :evaluations

  def session
    camp.session
  end

  def applicants
    session.applicants
  end

  def unevaluated_applicants
    session
      .applicants
      .where("NOT EXISTS (?)",
             evaluations
               .where("evaluations.applicant_id = applicants.id"))
  end

end
