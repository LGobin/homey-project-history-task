# frozen_string_literal: true

FactoryBot.define do
  factory :status_change do
    previous_status { Faker::Lorem.words(number: rand(1..5)) }
    next_status  { Faker::Lorem.words(number: rand(1..5)) }
  end
end