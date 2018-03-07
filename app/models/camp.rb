class Camp < ApplicationRecord
  belongs_to :session

  validates :name, presence: true
end
