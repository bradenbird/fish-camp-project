class CreateApplicants < ActiveRecord::Migration[5.1]
  def change
    create_table :applicants do |t|
      # column references in comments are in reference to the "FC Sample.xlsx"
      # spreadsheet in our Google drive folder

      t.integer :submission_id, null: false # column A
      t.datetime :submitted_at # column B
      t.string :uin, null: false # column C
      t.string :first_name # column D
      t.string :last_name # column E
      t.boolean :status # column F
      t.string :comment # column G
      t.string :updated_by # column H
      t.datetime :updated_at # column I
      t.integer :last_4_uin # column N
      t.string :tamu_email # column O
      t.string :other_email # column P
      t.string :phone # column Q
      t.string :gender # column R
      t.date :birthdate # column S
      t.string :classification # column T
      t.string :major # column U
      t.string :anticipated_graduation # column V
      t.string :address # column W
      # extracurriculars (newline chars might have been stripped. This might get ugly)
      t.text :extracurriculars # column X
      t.string :shirt_size # column Y
      t.string :parent_name # column AB
      t.string :parent_phone # column AC
      t.string :parent_email # column AD
      t.string :parent_address # column AE
      t.string :parent_city # column AF
      t.string :parent_state # column AG
      t.string :parent_zip # column AH
      t.string :alt_contact_1_name # column AJ
      t.string :alt_contact_1_phone # column AK
      t.string :alt_contact_1_email # column AL
      t.string :alt_contact_1_address # column AM
      t.string :alt_contact_1_city # column AN
      t.string :alt_contact_1_state # column AO
      t.string :alt_contact_1_zip # column AP
      t.string :alt_contact_2_name # column AR
      t.string :alt_contact_2_phone # column AS
      t.string :alt_contact_2_email # column AT
      t.string :alt_contact_2_address # column AU
      t.string :alt_contact_2_city # column AV
      t.string :alt_contact_2_state # column AW
      t.string :alt_contact_2_zip # column AX
      t.string :insurance_provider # column AY
      t.string :insurance_policy_number # column AZ
      t.string :insurance_policy_holder_name # column BA
      t.date :last_tetanus_booster_date # column BB
      t.text :drug_allergies # column BC
      t.text :food_allergies # column BD
      t.boolean :dietary_none # column BE
      t.boolean :dietary_red_meat # column BF
      t.boolean :dietary_vegan # column BG
      t.boolean :dietary_vegetarian # column BH
      t.boolean :dietary_dairy_free # column BI
      t.boolean :dietary_gluten_free # column BJ
      t.text :dietary_other # column BK
      t.text :medications # column BL
      t.boolean :accommodations_none # column BM
      t.boolean :accommodations_auditory # column BN
      t.boolean :accommodations_visual # column BO
      t.boolean :accommodations_physical # column BP
      t.text :accommodations_other # column BQ
      t.text :other_medical_concerns # column BR
      t.boolean :policy_agreement # column BV
      t.boolean :behavior_agreement # column BX
      t.boolean :personal_responsibility_agreement # column BZ
      t.boolean :liability_waiver # column CB
      t.boolean :photo_release # column CD
      t.boolean :camp_counselor # column CF
      t.boolean :crew_counselor # column CG
      t.boolean :pick_up_only # column CH
      t.string :pick_up_only # column CI
      t.boolean :session_A # column CJ
      t.boolean :session_B # column CK
      t.boolean :session_C # column CL
      t.boolean :session_D # column CM
      t.boolean :session_E # column CN
      t.boolean :session_F # column CO
      t.boolean :session_G # column CP
      t.text :camp_history # column CQ
      t.text :no_show_explanation # column CR
      t.boolean :abuse_agreement # column CS
      t.text :app_question_1 # column CV
      t.text :app_question_2 # column CW
      t.text :app_question_3 # column CX
      t.text :crew_question # column CZ
      t.timestamps
    end
  end
end
