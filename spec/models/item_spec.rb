require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user: @user)
  end

  describe '商品出品機能' do
    context '新規登録できるとき' do
      it 'すべての項目が正しく入力されていれば登録できる' do
        expect(@item).to be_valid
      end
      it 'カテゴリーが『--』以外なら登録できる' do
        @item.category_id = 2
        expect(@item).to be_valid
      end
      it '商品の状態が『--』以外なら登録できる' do
        @item.item_status_id = 2
        expect(@item).to be_valid
      end
      it '配送料の負担が『--』以外なら登録できる' do
        @item.shipping_cost_id = 2
        expect(@item).to be_valid
      end
      it '発送元の地域が『--』以外なら登録できる' do
        @item.prefecture_id = 2
        expect(@item).to be_valid
      end
      it '発送までの日数が『--』以外なら登録できる' do
        @item.shipping_date_id = 2
        expect(@item).to be_valid
      end
      it '販売価格が半角数字で300円〜9,999,999円なら登録できる' do
        @item.price = 300
        expect(@item).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'ユーザー登録していないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end

      it 'ユーザーが紐づいていないと保存ができない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end

      it '画像がないと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空欄だと出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明が空欄だと出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーが選択されていないと出品できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end

      it 'カテゴリーが『--』だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end

      it '商品の状態が選択されていないと出品できない' do
        @item.item_status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Item status must be other than 1')
      end

      it '商品の状態が『--』だと出品できない' do
        @item.item_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Item status must be other than 1')
      end

      it '配送料の負担が選択されてないと出品できない' do
        @item.shipping_cost_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping cost must be other than 1')
      end

      it '配送料の負担が『--』だと出品できない' do
        @item.shipping_cost_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping cost must be other than 1')
      end

      it '発送元の地域が選択されていないと出品できない' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
      end

      it '発送元の地域が『--』だと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
      end

      it '発送までの日数が選択されていないと出品できない' do
        @item.shipping_date_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping date must be other than 1')
      end

      it '発送までの日数が『--』だと出品できない' do
        @item.shipping_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping date must be other than 1')
      end

      it '価格が空欄だと出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が半角数値以外では保存できない' do
        @item.price = 'abcd1234１２００円'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it '価格が300円以下だと出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it '価格が9,999,999円以上だと出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
    end
  end
end
