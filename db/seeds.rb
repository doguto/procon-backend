require 'faker'
require 'set'

NUM_USERS = 10
NUM_POSTS = 30
NUM_FOLLOWS = 30

puts "Seeding users..."
users = NUM_USERS.times.map do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: "password",
    image: Faker::Avatar.image # ここで画像を追加
  )
end

puts "Seeding profiles..."
users.each do |user|
  user.create_profile!(
    bio: Faker::Lorem.paragraph(sentence_count: 2)
  )
end

puts "Seeding follow relationships..."
follow_set = Set.new

while follow_set.size < NUM_FOLLOWS
  follower = users.sample
  followed = users.sample

  next if follower == followed || follow_set.include?([follower.id, followed.id])

  follower.following << followed
  follow_set << [follower.id, followed.id]
end

puts "Seeding posts..."
NUM_POSTS.times do
  user = users.sample
  user.posts.create!(
    content: Faker::Lorem.sentence(word_count: rand(5..15)),
    status: "published",
    created_at: Faker::Time.backward(days: 30),
    updated_at: Time.current
  )
end

puts "✅ Done!"

