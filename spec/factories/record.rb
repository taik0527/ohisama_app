# frozen_string_literal: true

FactoryBot.define do
  factory :record do
    body { Faker::String.random }
    classroom { '女川小学校1年1組' }
    date { Faker::Date.between(from: '2021-01-01', to: '2021-09-20') }
  end
end
