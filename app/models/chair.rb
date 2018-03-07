class Chair < ApplicationRecord
  belongs_to :camp
  belongs_to :user
end
