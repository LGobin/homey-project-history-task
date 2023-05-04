# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { Faker::Lorem.words(number: rand(2..10)) }
    description  { Faker::Lorem.words(number: rand(2..100)) }
  end
end