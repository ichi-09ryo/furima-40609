require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'すべての入力事項があれば登録できる' do
        expect(@user).to be_valid
      end
      it 'パスワードが6文字以上半角英数字なら登録できる' do
        @user.password = '123abc'
        @user.password_confirmation = '123abc'
        expect(@user).to be_valid
      end
      it '名字が全角(漢字・ひらがな・カタカナ)なら登録できる' do
        @user.last_name = '市岡'
        expect(@user).to be_valid
      end
      it '名前が全角(漢字・ひらがな・カタカナ)なら登録できる' do
        @user.first_name = '凌介'
        expect(@user).to be_valid
      end
      it '名字のふりがなが全角(カタカナ)なら登録できる' do
        @user.last_name_kana = 'イチオカ'
        expect(@user).to be_valid
      end
      it '名前のふりがなが全角(カタカナ)なら登録できる' do
        @user.first_name_kana = 'リョウスケ'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくかないとき' do
      it 'ニックネームが空欄だと保存できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが空欄だと保存できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスがすでに登録されていると保存できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'パスワードが空欄だと保存できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードが5文字以下だと保存できない' do
        @user.password = '1234'
        @user.password_confirmation = '1234'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it '名字が全角(漢字、ひらがな、カタカナ)でないと登録できない' do
        @user.last_name = 'ichioka'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it '名前が全角(漢字、ひらがな、カタカナ)でないと登録できない' do
        @user.first_name = 'ryosuke'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it '名字のふりがなが全角(カタカナ)でないと登録できない' do
        @user.last_name_kana = 'いちおか'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it '名前のふりがなが全角(カタカナ)でないと登録できない' do
        @user.first_name_kana = 'りょうすけ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it '生年月日が空欄だと保存できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
