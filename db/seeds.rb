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
(1..10).each do |i|
  Applicant.create!(submission_id: i,
                    uin: Faker::Number.number(9),
                    first_name: Faker::Name.first_name,
                    last_name: Faker::Name.last_name,
                    session_A: Faker::Boolean.boolean,
                    session_B: Faker::Boolean.boolean,
                    session_C: Faker::Boolean.boolean,
                    session_D: Faker::Boolean.boolean,
                    session_E: Faker::Boolean.boolean,
                    session_F: Faker::Boolean.boolean,
                    session_G: Faker::Boolean.boolean)
end

# Create some users using faker

(1..3).each do |i|
  user = User.create!(google_uid: i,
                      uin: Faker::Number.number(9),
                      name: Faker::Name.first_name,
                      role: "chair")
  chair = user.create_chair!()


# Create a chair for each user using faker, and assign them to a camp
