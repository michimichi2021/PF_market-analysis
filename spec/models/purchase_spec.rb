require 'rails_helper'

RSpec.describe 'purchaseモデルのテスト', type: :model do
  before do
    @purchase = FactoryBot.build(:purchase)
  end

  context "バリデーションチェック" do
    it "有効な投稿内容の場合は保存されるか" do
      expect(@purchase).to be_valid
    end
    it "nameが空欄でないこと" do
      @purchase.name = ''
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include "Name can't be blank"
    end
    it "addressが空欄でないこと" do
      @purchase.address = ''
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include "Address can't be blank"
    end
    it "postal_codeが空欄でないこと" do
      @purchase.postal_code = ''
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include "Postal code is invalid"
    end
    it "postal_codeが7文字未満であれば無効な状態であること" do
      @purchase.postal_code = "a" * 6
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include "Postal code is invalid"
    end
    it "postal_codeが7文字を超えると無効な状態であること" do
      @purchase.postal_code = "a" * 8
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include "Postal code is invalid"
    end
  end

  describe 'アソシエーションのテスト' do
    context 'itemモデルとの関係' do
      it 'N:1となっている' do
        expect(Purchase.reflect_on_association(:item).macro).to eq :belongs_to
      end
    end

    context 'userモデルとの関係' do
      it 'N:1となっている' do
        expect(Purchase.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
