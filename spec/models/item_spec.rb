require 'rails_helper'

RSpec.describe 'itemモデルのテスト', type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('app/assets/images/no_image.jpeg')
  end

  context "バリデーションチェック" do
    it "有効な内容の場合は投稿されるか" do
      expect(@item).to be_valid
    end
    it "nameが空欄でないこと" do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "商品名を入力してください"
    end
    it "priceが空欄でないこと" do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "商品金額は数値で入力してください"
    end
    it "priceが299円以下であったら商品を出品できない" do
      @item.price = '299'
      @item.valid?
      expect(@item.errors.full_messages).to include "商品金額は300以上の値にしてください"
    end
    it "priceが300円ちょうどで商品を出品できる" do
      @item.price = '300'
      @item.valid?
      expect(@item).to be_valid
    end
    it "priceが1000000円以下で商品を出品できる" do
      @item.price = '1000000'
      @item.valid?
      expect(@item).to be_valid
    end
    it "priceが1000000円より高ければ商品を出品できない" do
      @item.price = '1000001'
      @item.valid?
      expect(@item.errors.full_messages).to include "商品金額は1000000以下の値にしてください"
    end
  end

  describe 'アソシエーションのテスト' do
    context 'tagモデルとの関係' do
      it '1:Nとなっている' do
        expect(Item.reflect_on_association(:tags).macro).to eq :has_many
      end
    end

    context 'commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Item.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'genreモデルとの関係' do
      it '1:Nとなっている' do
        expect(Item.reflect_on_association(:genres).macro).to eq :has_many
      end
    end

    context 'favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(Item.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'purchaseモデルとの関係' do
      it '1:1となっている' do
        expect(Item.reflect_on_association(:purchase).macro).to eq :has_one
      end
    end

    context 'userモデルとの関係' do
      it 'N:1となっている' do
        expect(Item.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
