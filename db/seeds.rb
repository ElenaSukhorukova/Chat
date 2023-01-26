(15 - User.count).times do |i|
  number = rand(1..50)
  user_name = Faker::Name.first_name
  email = "email#{number}@email.com"
  password_digest = '123Test123!+'
  
  unless User.find_by(email: email)
    User.create! user_name: user_name, email: email, password_digest: password_digest
  end
end