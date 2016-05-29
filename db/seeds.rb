# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do |n|
    
    name = Faker::Name.name
    email = "example#{n+1}@example.com"
    password = "password"
    uid = n
    provider = "provider#{n+1}"
User.create!(name: name, email: email, password: password, password_confirmation: password, uid: uid, provider: provider)
end

100.times do |n|

    title = "タイトル#{n+1}"
    content = "内容#{n+1}"
    user_id = Random.rand(365..980)
Blog.create!(title: "tilte#{n}", content: "content#{n}", user_id: user_id)
end