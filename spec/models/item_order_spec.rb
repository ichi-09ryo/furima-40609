require 'rails_helper'

RSpec.describe ItemOrder, type: :model do
  before do
    @user = FactoryBot.create(:user)
    sleep 0.1  # 少し待機することでタイミングの問題を回避
    @item = FactoryBot.create(:item)
    sleep 0.1  # 少し待機することでタイミングの問題を回避
    @item_order = FactoryBot.build(:item_order, user_id: @user.id, item_id: @item.id)
    sleep 0.1  # 少し待機することでタイミングの問題を回避
  end

  describe '商品購入' do
    context '購入がうまくいくとき' do
      it '全ての値が正しく入力されていれば購入できること' do
        expect(@item_order).to be_valid
      end

      it '建物名が空でも購入できること' do
        @item_order.building = ''
        expect(@item_order).to be_valid
      end
    end

    context '購入がうまくいかないとき' do
      it 'クレジットカード情報が空では購入できないこと' do
        @item_order.token = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Token can't be blank")
      end

      it '郵便番号が空では購入できないこと' do
        @item_order.postcode = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Postcode can't be blank")
      end

      it '郵便番号が半角のハイフンを含んだ正しい形式でないと購入できないこと' do
        @item_order.postcode = '1234567'
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include('Postcode is invalid. Include hyphen(-)')
      end

      it '都道府県が『--』では購入できないこと' do
        @item_order.prefecture_id = 1
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空では購入できないこと' do
        @item_order.city = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では購入できないこと' do
        @item_order.block = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Block can't be blank")
      end

      it '携帯番号が空では購入できないこと' do
        @item_order.phone_number = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が9桁以下の場合保存できないこと' do
        @item_order.phone_number = '090123456'
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include('Phone number is invalid')
      end
    
      it '電話番号が12桁以上の場合保存できないこと' do
        @item_order.phone_number = '090123456789'
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include('Phone number is invalid')
      end

      it '携帯番号が半角数字でないと購入できないこと' do
        @item_order.phone_number = '０９０１２３４５６７８'
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include('Phone number is invalid')
      end

      it 'userが紐づいていない場合購入できないこと' do
        @item_order.user_id = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐づいていない場合購入できないこと' do
        @item_order.item_id = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
