# frozen_string_literal:true

require 'rails_helper'

RSpec.describe 'userモデルのテスト', type: :model do
  before do
    @user = FactoryBot.build(:user)
    @user.image = fixture_file_upload('app/assets/images/no_image.jpeg')
  end

  context "バリデーションチェック" do
    it "有効な登録内容の場合は保存されるか" do
      expect(@user).to be_valid
    end
    it "last_nameが空欄でないこと" do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name can't be blank"
    end
    it "first_nameが空欄でないこと" do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end
    it "last_name_kanaが空欄でないこと" do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name kana can't be blank"
    end
    it "first_name_kanaが空欄でないこと" do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "First name kana can't be blank"
    end
    it "addressが空欄でないこと" do
      @user.address = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Address can't be blank"
    end
    it "telephone_numberが空欄でないこと" do
      @user.telephone_number = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Telephone number is not a number"
    end
    it "emailが空欄でないこと" do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Email is invalid"
    end
    it "postal_codeが空欄でないこと" do
      @user.postal_code = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Postal code is invalid"
    end
    it "postal_codeが7文字未満であれば無効な状態であること" do
      @user.postal_code = "a" * 6
      @user.valid?
      expect(@user.errors.full_messages).to include "Postal code is invalid"
    end
    it "postal_codeが7文字を超えると無効な状態であること" do
      @user.postal_code = "a" * 8
      @user.valid?
      expect(@user.errors.full_messages).to include "Postal code is invalid"
    end
  end

  describe 'アソシエーションのテスト' do
    context 'purchaseモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:purchases).macro).to eq :has_many
      end
    end

    context 'commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'itemモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:items).macro).to eq :has_many
      end
    end

    context 'favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
  end
end
