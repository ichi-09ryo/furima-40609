
FactoryBot.define do
  factory :order do
    postcode    {'123-4567'}
    prefecture_id  {'3'}
    city{'横浜市'}
    block     {'1-1-1'}
    building  {'建物ビル'}
    phone_number   {'09022223333'}
    association :user        
    association :item       
  end
end
