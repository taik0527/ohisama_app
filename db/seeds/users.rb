puts 'Start inserting seed "users" ...'
10.times do
  user = User.new(
    email: Faker::Internet.unique.email,
    username: Faker::Name.unique.name,
    password: 'password',
    password_confirmation: 'password',
    admin: false
  )
  user.save
  puts "\"#{user.username}\" has created!"
end