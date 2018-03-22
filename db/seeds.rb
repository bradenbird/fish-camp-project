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

# Create some users using faker

# Create a chair for each user using faker, and assign them to a camp 
