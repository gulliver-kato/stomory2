# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
    name: '山田太郎',
    nickname: 'タロー',
    age: '30',
    gender: '男性',
    maritalstatus: '既婚',
    prefecture: '東京都',
    email: 'test@testmail.com',
    password: '000000',
    password_confirmation: '000000',
    admin: 'true',
    )

20.times do |n|
    name  = "example-#{n+1}"
    nickname = "example_nick-#{n+1}"
    email = "example-#{n+1}@example.com"
    User.create!(
        name: name,
        nickname: nickname,
        age: '30',
        gender: '男性',
        maritalstatus: '既婚',
        prefecture: '東京都',
        email: email,
        password: '000000',
        password_confirmation: '000000',
        admin: 'false',
        )
end

20.times do |n|
    title  = "ハワイ旅行#{n+1}"
    Story.create!(
        title: title,
        thumbnail_image: open("#{Rails.root}/db/fixtures/1.jpeg"),
        user_id: 1,
        )
end

20.times do |n|
    text  = "ハワイ#{n+1}日目"
    Part.create!(
        text: text,
        image: open("#{Rails.root}/db/fixtures/1.jpeg"),
        story_id: 1,
        )
end