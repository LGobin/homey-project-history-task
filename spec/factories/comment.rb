# frozen_string_literal: true

FactoryBot.define do
    factory :comment do
      content { Faker::Lorem.words(number: rand(2..100)) }
    end
  end