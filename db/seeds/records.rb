# frozen_string_literal: true

puts 'Start inserting seed "records" ...'
10.times do |x|
  record = Record.new(
    date: Faker::Date.between(from: '2020-01-01', to: '2021-01-01'),
    classroom: '女川小学校3年1組',
    body: Faker::Lorem.sentence
  )
  record.save
  book = Book.find(x + 1)
  record.books << book
  user = User.find(x + 1)
  record.users << user
  puts 'record has created!'
end
