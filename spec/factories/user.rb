FactoryBot.define do
  factory :user do
    name { "testuser1" }
    email {"yoshitaka.sample@sample.com"}
    password {"password"}
    telephone_number {"0127117117"}
    birth_day {Date.new(2020, 9, 5)}
  end
end