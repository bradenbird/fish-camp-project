class Chair < ApplicationRecord
  belongs_to :camp
  belongs_to :user

  has_many :evaluations
  has_many :evaluated_applicants,
           through: :evaluations,
           source: :applicant
  has_many :good_applicants,
           ->() { where(rating: "A") },
           source: :applicant,
           through: :evaluations

  def session
    camp.session
  end

  def unevaluated_applicants
    session
      .applicants
      .where("NOT EXISTS (?)",
             evaluations
               .where("evaluations.applicant_id = applicants.id"))
  end

end
