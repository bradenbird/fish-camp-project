class Interview < ApplicationRecord
	belongs_to :chair
	belongs_to :applicant
end
