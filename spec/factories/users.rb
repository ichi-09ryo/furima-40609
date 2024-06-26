FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6) + '1a' }
    password_confirmation { password }
    last_name             { '市岡' }
    first_name            { '凌介' }
    last_name_kana        { 'イチオカ' }
    first_name_kana       { 'リョウスケ' }
    birthday              { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
