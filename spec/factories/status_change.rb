# frozen_string_literal: true

FactoryBot.define do
  factory :status_change do
    previous_status { Faker::Lorem.sentence(word_count: 3) }
    next_status { Faker::Lorem.sentence(word_count: 4) }
  end
end
