# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

10.times do |n|
  User.create!(
    email:"test#{n + 1}@test.com",
    name:"テストユーザー#{n + 1}",
    password:"testhoge",
    telephone_number:00000000000,
    birth_day:"2024-04-14"
  )

  Tweet.create!(
    content:"test#{n + 1}",
    user_id:1 + n
  )
end

Relationship.create!(
    followed_id:2,
    follower_id:1
  )