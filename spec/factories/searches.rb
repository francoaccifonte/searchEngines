# frozen_string_literal: true

# == Schema Information
#
# Table name: searches
#
#  id          :bigint           not null, primary key
#  engine      :string
#  query_terms :string           default([]), is an Array
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :search do
    engine { %w[google bing].sample }
    query_terms { Array.new(rand(1..10)) { Faker::Lorem.word } }

    trait :google do
      engine { 'google' }
    end

    trait :bing do
      engine { 'bing' }
    end
  end
end
