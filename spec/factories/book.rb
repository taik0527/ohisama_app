FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    google_books_api_id { Faker::Number.number(digits: 10) }
    publisher { Faker::Book.publisher }
    storage { Faker::Boolean.boolean }
  end
end