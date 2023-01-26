(15 - User.count).times do |i|
  number = rand(1..50)
  user_name = Faker::Name.first_name
  email = "email#{number}@email.com"
  password_digest = '123Test123!+'
  
  unless User.find_by(email: email)
    User.create! user_name: user_name, email: email, password_digest: password_digest
  end
end

(35 - Message.count).times do |i|
  user = User.find User.ids.sample
  body = Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 3)
  Message.create! user: user, body: body
end
