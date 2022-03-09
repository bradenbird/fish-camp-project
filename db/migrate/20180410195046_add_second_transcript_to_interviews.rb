class AddSecondTranscriptToInterviews < ActiveRecord::Migration[5.1]
  def change
    change_table :interviews do |t|
      t.rename :transcript, :transcript1
      t.text :transcript2
    end
  end
end
