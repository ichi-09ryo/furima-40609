FactoryBot.define do
  factory :item_order do
    token { 'tok_abcdefghijk00000000000000000' }
    postcode       { '123-4567' }
    prefecture_id  { 2 }
    city           { '横浜市' }
    block          { '青山1-1-1' }
    building       { '柳ビル103' }
    phone_number   { '09012345678' }
  end
end
