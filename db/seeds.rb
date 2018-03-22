# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create sessions
require 'faker'

start_date = Date.parse("July 1")
("A".."G").each do |letter|
  Session.create!(name: letter,
                  year: start_date.year,
                  start_date: start_date,
                  end_date: start_date + 3.days)
  start_date += 1.week
end

# Create some applicants using faker, and assign to them random session availabilities
session_ids = Session.pluck(:id)
(1..10).each do |i|
  applicant = Applicant.create!(submission_id: Faker::Number.number(10),
                                uin: Faker::Number.number(9),
                                first_name: Faker::Name.first_name,
                                last_name: Faker::Name.last_name)
  num_sessions = rand(session_ids.count) + 1
  available_sessions = session_ids.sample(num_sessions)
  available_sessions.each do |session_id|
    applicant.session_availabilities.create!(session_id: session_id)
  end
end

# Create some users using faker

(1..3).each do |i|
  user = User.create!(google_uid: Faker::Crypto.sha1,
                      uin: Faker::Number.number(9),
                      name: Faker::Name.first_name,
                      role: "chair")
  chair = user.create_chair!()
end


# Create a chair for each user using faker, and assign them to a camp
