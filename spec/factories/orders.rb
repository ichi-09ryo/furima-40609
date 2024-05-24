
FactoryBot.define do
  factory :order do
    postal_code    {'123-4567'}
    prefecture_id  {'3'}
    city_name      {'横浜市'}
    block_name     {'1-1-1'}
    building_name  {'建物ビル'}
    phone_number   {'09022223333'}
    association :user        
    association :item       
  end
end
