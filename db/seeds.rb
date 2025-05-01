users = [
  { name: "Alice", email: "alice@example.com", password: "password" },
  { name: "Bob", email: "bob@example.com", password: "password" },
  { name: "Charlie", email: "charlie@example.com", password: "password" },
  { name: "Dave", email: "dave@example.com", password: "password" },
  { name: "Eve", email: "eve@example.com", password: "password" }
]

users.each do |user|
  unless User.exists?(email: user[:email])
    User.create!(user)
  end
end

users.each do |user|
  u = User.find_by(email: user[:email])  
  Profile.create!(user_id: u.id, bio: "Bio for #{u.name}") if u
end

users.each do |user|
  current_user = User.find_by(email: user[:email])
  next unless current_user

  User.where.not(id: current_user.id).each do |other_user|
    current_user.following << other_user unless current_user.following.include?(other_user)
  end
end

users.each_with_index do |user, i|
  u = User.find_by(email: user[:email]) 
  Post.create!(
    user: u,  
    content: "サンプル投稿#{i + 1}",  
    status: "published",
    created_at: Time.current,
    updated_at: Time.current
  )
end
