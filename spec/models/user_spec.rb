require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  describe '存在性の検証' do
    it '情報が存在すれば登録できる' do
      expect(user).to be_valid
    end
    it 'nicknameが空の場合登録できない' do
      user.nickname = ''
      user.valid?
      expect(user.errors.full_messages).to include('ニックネームを入力してください')
    end
    it 'emailが空の場合登録できない' do
      user.email = ''
      user.valid?
      expect(user.errors.full_messages).to include('メールアドレスを入力してください')
    end
    it 'phone_numberが空の場合登録できない' do
      user.phone_number = ''
      user.valid?
      expect(user.errors.full_messages).to include('電話番号を入力してください')
    end
    it 'passwordが空の場合登録できない' do
      user.password = ''
      user.valid?
      expect(user.errors.full_messages).to include('パスワードを入力してください')
    end
    it 'password_confirmationが空の場合登録できない' do
      user.password_confirmation = ''
      user.valid?
      expect(user.errors.full_messages).to include('パスワード（確認用）を入力してください')
    end
  end
  describe '文字数の検証' do
    it 'nicknameが25字の場合登録できない' do
      user.nickname = ('a' * 25)
      user.valid?
      expect(user.errors.full_messages).to include('ニックネームは24文字以内で入力してください')
    end
    it 'emailが9字の場合登録できない' do
      user.email = "#{ 'a' * 2 }@au.com"
      user.valid?
      expect(user.errors.full_messages).to include('メールアドレスは10文字以上で入力してください')
    end
    it 'emailが45字の場合登録できない' do
      user.email = "#{ 'a' * 35 }@gmail.com"
      user.valid?
      expect(user.errors.full_messages).to include('メールアドレスは44文字以内で入力してください')
    end
    it 'phone_numberが14字の場合登録できない' do
      user.phone_number = '080-0001-00001'
      user.valid?
      expect(user.errors.full_messages).to include('電話番号は13文字で入力してください')
    end
    it 'phone_numberが14字の場合登録できない' do
      user.phone_number = '080-0001-00001'
      user.valid?
      expect(user.errors.full_messages).to include('電話番号は13文字で入力してください')
    end
  end
  describe '一意性の検証' do
    it 'emailが重複している場合登録できない' do
      dup_user = create(:user, :dup_email)
      user.valid?
      expect(user.errors.full_messages).to include('メールアドレスはすでに存在します')
    end
    it 'phone_numberが重複している場合登録できない' do
      dup_user = create(:user, :dup_phone_number)
      user.valid?
      expect(user.errors.full_messages).to include('電話番号はすでに存在します')
    end
  end
  describe '正規表現の検証' do
    context 'emailの場合' do
      # ユーザー名が3-30文字のみ有効の検証、先頭半角英字の場合有効の検証は割愛
      it '先頭が小文字半角数字の場合登録できる' do
        user.email = "0#{user.email}"
        expect(user).to be_valid
      end
      it '先頭が小文字半角英字、半角数字以外の場合登録できない' do
        user.email = "-#{user.email}"
        expect(user).to be_invalid
      end
      it '半角英小文字、半角数字、-（ハイフン）、.（ドット）、_（アンダーバー）がユーザー名に含まれている場合登録できる' do
        user.email = 'test-._@gmail.com'
        expect(user).to be_valid
      end
      it '半角英小文字、半角数字、-（ハイフン）、.（ドット）、_（アンダーバー）以外の文字がユーザー名に含まれている場合登録できない' do
        user.email = 'tesT@gmail.com'
        expect(user).to be_invalid
      end
      it '指定したドメイン名の場合登録できる' do
        domains = ['yahoo.co.jp', 'gmail.com', 'ezweb.ne.jp', 'au.com', 'docomo.ne.jp', 'i.softbank.jp', 'softbank.ne.jp', 'excite.co.jp', 'googlemail.com', 'hotmail.co.jp', 'hotmail.com', 'icloud.com', 'live.jp', 'me.com', 'mineo.jp', 'nifty.com', 'outlook.com', 'outlook.jp', 'yahoo.ne.jp', 'ybb.ne.jp', 'ymobile.ne.jp']
        domains.each do |domain|
          user.email = "test@#{domain}"
          expect(user).to be_valid
        end
      end
      it '指定したドメイン名以外の場合登録できない' do
        user.email = 'test@example.com'
        expect(user).to be_invalid
      end
    end
    context 'phone_numberの場合' do
      # 文字数の検証は割愛
      it '先頭3桁が090、080、070の場合登録できる' do
        initials = ['090', '080', '070']
        initials.each do |initial|
          user.phone_number = "#{initial}-1234-5678"
          expect(user).to be_valid
        end
      end
      it '指定した番号以外の場合登録できない' do
        user.phone_number = '060-1234-5678'
        expect(user).to be_invalid
      end
    end
  end
  describe 'callbackの検証' do
    context 'complete_hypenの検証' do
      fit 'ハイフンなしで値が送られた場合ハイフンを補完する' do
        no_hyphen = '09012345678'
        user.phone_number = no_hyphen
        user.valid?
        expect(user.phone_number).to eq("090-1234-5678")
      end
    end
  end
end
