FactoryBot.define do
  factory :admin_user, class: User do
    name { 'test2' }
    nickname { 'nick_test2' }
    age { '44' }
    gender { '女性' }
    maritalstatus { '既婚' }
    prefecture { '東京都' }
    email { 'admin@example.com' }
    password { '000000' }
    admin { true }
  end
  factory :user do
    name { 'test1' }
    nickname { 'nick_test1' }
    age { '33' }
    gender { '男性' }
    maritalstatus { '既婚' }
    prefecture { '東京都' }
    email { 'test1@example.com' }
    password { '111111' }
    admin { false }
  end
end