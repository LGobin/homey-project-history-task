# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { Faker::Lorem.sentence(word_count: 5) }
    description  { Faker::Lorem.paragraph(sentence_count: 5) }
  end
end