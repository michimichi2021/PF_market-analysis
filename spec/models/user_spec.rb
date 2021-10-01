# frozen_string_literal:true

require 'rails_helper'

RSpec.describe 'userモデルのテスト', type: :model do
  before do
    @user = FactoryBot.build(:user)
    @user.image = fixture_file_upload('app/assets/images/no_image.jpeg')
  end

  describe "フォローフォロワー" do
    it "フォロー" do
      @other_user = FactoryBot.create(:user, image: fixture_file_upload('app/assets/images/no_image.jpeg'))
      @another_user = FactoryBot.create(:user, image: fixture_file_upload('app/assets/images/no_image.jpeg'))
      Relationship.create(follower_id: @other_user.id, followed_id: @another_user.id)
      expect(@other_user.following_user.map(&:id)).to include @another_user.id
    end
  end

  context "バリデーションチェック" do
    it "有効な登録内容の場合は保存されるか" do
      expect(@user).to be_valid
    end
    it "last_nameが空欄でないこと" do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "名前(姓)を入力してください"
    end
    it "first_nameが空欄でないこと" do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "名前(名)を入力してください"
    end
    it "last_name_kanaが空欄でないこと" do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "フリガナ(セイ)を入力してください"
    end
    it "first_name_kanaが空欄でないこと" do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "フリガナ(メイ)を入力してください"
    end
    it "addressが空欄でないこと" do
      @user.address = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "住所を入力してください"
    end
    it "telephone_numberが空欄でないこと" do
      @user.telephone_number = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "電話番号は数値で入力してください"
    end
    it "emailが空欄でないこと" do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Eメールを入力してください"
    end
    it "postal_codeが空欄でないこと" do
      @user.postal_code = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "郵便番号は不正な値です"
    end
    it "postal_codeが7文字未満であれば無効な状態であること" do
      @user.postal_code = "a" * 6
      @user.valid?
      expect(@user.errors.full_messages).to include "郵便番号は不正な値です"
    end
    it "postal_codeが7文字を超えると無効な状態であること" do
      @user.postal_code = "a" * 8
      @user.valid?
      expect(@user.errors.full_messages).to include "郵便番号は不正な値です"
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
