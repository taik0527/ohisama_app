# frozen_string_literal: true

require 'securerandom'

FactoryBot.define do
  factory :invitation do
    email { Faker::Internet.unique.email }
    token { SecureRandom.hex(10) }
    expired_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
  end
end
