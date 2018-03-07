class Session < ApplicationRecord
  has_many :session_availabilities
  has_many :applicants, through: :session_availabilities
  has_many :camps
  has_many :chairs, through: :camps

  validates :name, presence: true
  validates :year, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if start_date.nil? || end_date.nil?
    if end_date <= start_date
      errors.add(:end_date, "must be after start_date")
    end
  end
end
