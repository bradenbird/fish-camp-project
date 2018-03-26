require 'csv'
require 'iconv'
require 'roo'

class Applicant < ApplicationRecord
  has_many :session_availabilities
  has_many :sessions, through: :session_availabilities

  validates :submission_id, presence: true
  validates :uin, presence: true

  def self.import(path, extension)
    spreadsheet = open_spreadsheet(path, extension)

    session_cells = {'CJ' => Session.find_by(name: 'A'),
                     'CK' => Session.find_by(name: 'B'),
                     'CL' => Session.find_by(name: 'C'),
                     'CM' => Session.find_by(name: 'D'),
                     'CN' => Session.find_by(name: 'E'),
                     'CO' => Session.find_by(name: 'F'),
                     'CP' => Session.find_by(name: 'G')}

    (2..spreadsheet.last_row).each do |i|
      applicant = Applicant.new
      # For now let's hard code the spreadsheet indexes
      applicant.submission_id = spreadsheet.cell(i,'A')
      applicant.submitted_at = spreadsheet.cell(i,'B')
      applicant.uin = spreadsheet.cell(i,'M')
      applicant.first_name = spreadsheet.cell(i,'K')
      applicant.last_name = spreadsheet.cell(i,'L')
      if (spreadsheet.cell(i,'F') == 'Approved')
        applicant.status = true
      else
        applicant.status = false
      end
      applicant.comment = spreadsheet.cell(i,'G')
      applicant.updated_by = spreadsheet.cell(i,'H')
      applicant.updated_at = spreadsheet.cell(i,'I')
      applicant.last_4_uin = spreadsheet.cell(i,'N')
      applicant.tamu_email = spreadsheet.cell(i,'O')
      applicant.other_email = spreadsheet.cell(i,'P')
      applicant.phone = spreadsheet.cell(i,'Q')
      applicant.gender = spreadsheet.cell(i, 'R')
      applicant.birthdate = spreadsheet.cell(i,'S')
      applicant.classification = spreadsheet.cell(i,'T')
      applicant.major = spreadsheet.cell(i,'U')
      applicant.anticipated_graduation = spreadsheet.cell(i,'V')
      applicant.address = spreadsheet.cell(i,'W')
      applicant.extracurriculars = spreadsheet.cell(i,'X')
      applicant.shirt_size = spreadsheet.cell(i,'Y')

      applicant.parent_name = spreadsheet.cell(i,'AB')
      applicant.parent_phone = spreadsheet.cell(i,'AC')
      applicant.parent_email = spreadsheet.cell(i,'AD')
      applicant.parent_address = spreadsheet.cell(i,'AE')
      applicant.parent_city = spreadsheet.cell(i,'AF')
      applicant.parent_state = spreadsheet.cell(i,'AG')
      applicant.parent_zip = spreadsheet.cell(i,'AH')

      applicant.alt_contact_1_name = spreadsheet.cell(i,'AJ')
      applicant.alt_contact_1_phone = spreadsheet.cell(i,'AK')
      applicant.alt_contact_1_email = spreadsheet.cell(i, 'AL')
      applicant.alt_contact_1_address = spreadsheet.cell(i,'AM')
      applicant.alt_contact_1_city = spreadsheet.cell(i,'AN')
      applicant.alt_contact_1_state = spreadsheet.cell(i,'AO')
      applicant.alt_contact_1_zip = spreadsheet.cell(i,'AP')

      applicant.alt_contact_2_name = spreadsheet.cell(i,'AR')
      applicant.alt_contact_2_phone = spreadsheet.cell(i,'AS')
      applicant.alt_contact_2_email = spreadsheet.cell(i, 'AT')
      applicant.alt_contact_2_address = spreadsheet.cell(i,'AU')
      applicant.alt_contact_2_city = spreadsheet.cell(i,'AV')
      applicant.alt_contact_2_state = spreadsheet.cell(i,'AW')
      applicant.alt_contact_2_zip = spreadsheet.cell(i,'AX')

      applicant.insurance_provider = spreadsheet.cell(i,'AY')
      applicant.insurance_policy_number = spreadsheet.cell(i,'AZ')
      applicant.insurance_policy_holder_name = spreadsheet.cell(i,'BA')
      applicant.last_tetanus_booster_date = spreadsheet.cell(i,'BB')

      applicant.drug_allergies = spreadsheet.cell(i,'BC')
      applicant.food_allergies = spreadsheet.cell(i,'BD')

      if(spreadsheet.cell(i,'BE') == "None")
        applicant.dietary_none = true
        applicant.dietary_red_meat = false
        applicant.dietary_vegan = false
        applicant.dietary_vegetarian = false
        applicant.dietary_dairy_free = false
        applicant.dietary_gluten_free = false
        applicant.dietary_other = spreadsheet.cell(i,'BJ')
      else
        applicant.dietary_none = false
        if(spreadsheet.cell(i,'BF').blank?)
          applicant.dietary_red_meat = false
        else
          applicant.dietary_red_meat = true
        end

        if(spreadsheet.cell(i,'BG').blank?)
          applicant.dietary_vegan = false
        else
          applicant.dietary_vegan = true
        end

        if(spreadsheet.cell(i,'BH').blank?)
          applicant.dietary_vegetarian = false
        else
          applicant.dietary_vegetarian = true
        end

        if(spreadsheet.cell(i,'BI').blank?)
          applicant.dietary_dairy_free = false
        else
          applicant.dietary_dairy_free = true
        end

        if(spreadsheet.cell(i,'BJ').blank?)
          applicant.dietary_gluten_free = false
        else
          applicant.dietary_gluten_free = true
        end

        applicant.dietary_other = spreadsheet.cell(i,'BK')
      end

      applicant.medications = spreadsheet.cell(i,'BL')
      if(spreadsheet.cell(i,'BM') == "None")
        applicant.accommodations_none = true
        applicant.accommodations_auditory = false
        applicant.accommodations_visual = false
        applicant.accommodations_physical = false
      else
        applicant.accommodations_none = false
        if(spreadsheet.cell(i,'BN').blank?)
          applicant.accommodations_auditory = false
        else
          applicant.accommodations_auditory = true
        end

        if(spreadsheet.cell(i,'BO').blank?)
          applicant.accommodations_visual = false
        else
          applicant.accommodations_visual = true
        end

        if(spreadsheet.cell(i,'BP').blank?)
          applicant.accommodations_physical = false
        else
          applicant.accommodations_physical = true
        end
      end
      applicant.accommodations_other = spreadsheet.cell(i,'BQ')
      applicant.other_medical_concerns = spreadsheet.cell(i,'BR')

      if(spreadsheet.cell(i,'BV').blank?)
          applicant.policy_agreement = false
      else
          applicant.policy_agreement = true
      end

      if(spreadsheet.cell(i,'BX').blank?)
          applicant.behavior_agreement = false
      else
          applicant.behavior_agreement = true
      end

      if(spreadsheet.cell(i,'BZ').blank?)
          applicant.personal_responsibility_agreement = false
      else
          applicant.personal_responsibility_agreement = true
      end

      if(spreadsheet.cell(i,'CB').blank?)
          applicant.liability_waiver = false
      else
          applicant.liability_waiver = true
      end

      if(spreadsheet.cell(i,'CD').blank?)
          applicant.photo_release = false
      else
          applicant.photo_release = true
      end

      if(spreadsheet.cell(i,'CF').blank?)
          applicant.camp_counselor = false
      else
          applicant.camp_counselor = true
      end

      if(spreadsheet.cell(i,'CG').blank?)
          applicant.crew_counselor = false
      else
          applicant.crew_counselor = true
      end

      applicant.pick_up_only = spreadsheet.cell(i,'CI')

      applicant.camp_history = spreadsheet.cell(i,'CQ')
      applicant.no_show_explanation = spreadsheet.cell(i,'CR')
      if(spreadsheet.cell(i,'CS').blank?)
          applicant.abuse_agreement = false
      else
          applicant.abuse_agreement = true
      end

      applicant.app_question_1 = spreadsheet.cell(i,'CV')
      applicant.app_question_2 = spreadsheet.cell(i,'CW')
      applicant.app_question_3 = spreadsheet.cell(i,'CX')
      applicant.crew_question = spreadsheet.cell(i,'CZ')
      applicant.created_at = Time.now.strftime("%d/%m/%Y %H:%M")

      applicant.save!

      # changing import script here for new session availability modeling

      session_cells.each do | column, session |
        unless spreadsheet.cell(i, column).blank?
          applicant.session_availabilities.create!(session: session)
        end
      end

    end
  end

  def self.open_spreadsheet(path, extension)
    raise ArgumentError, "Please Choose a .csv, .xlx, or .xlsx file" unless (extension == ".csv" || extension == ".xls" || extension == ".xlsx")
    Roo::Spreadsheet.open(path, extension: extension)
    # puts file.class.inspect
    # case File.extname(file.original_filename)
    # when ".csv" then Roo::CSV.new(file.path)
    # when ".xls" then Roo::Excel.new(file.path)
    # when ".xlsx" then Roo::Excelx.new(file.path)
    # else raise "Unknown file type: #{file.original_filename}"
    # end
  end

end
