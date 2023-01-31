# frozen_string_literal: true

(15 - User.count).times do |_i|
  number = rand(1..50)
  user_name = Faker::Name.first_name
  email = "email#{number}@email.com"
  password = '123Test123!+'

  User.create! user_name: user_name, email: email, password: password unless User.find_by email: email
end

(10 - Chatroom.count).times do
  chatroom_name = Faker::Hobby.activity
  user = User.find User.ids.sample
  Chatroom.create! chatroom_name: chatroom_name, user: user unless Chatroom.find_by chatroom_name: chatroom_name
end

Chatroom.all.each do |chatroom|
  (8 - chatroom.users.count).times do
    user = User.find(User.ids.sample)

    chatroom.users << user unless ChatroomUser.find_by(user: user, chatroom: chatroom)
  end
  (15 - chatroom.messages.count).times do
    user = chatroom.users.find_by id: chatroom.users.ids.sample
    body = Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 3)

    Message.create! user: user, body: body, chatroom: chatroom
  end

  chatroom.users.each do |user|
    chatroom.messages.each do |message|
      Like.create! message: message, user: user unless Like.find_by message: message, user: user
    end
  end
end
