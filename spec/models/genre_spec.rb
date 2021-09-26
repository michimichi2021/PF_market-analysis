require 'rails_helper'

RSpec.describe 'genreモデルのテスト', type: :model do
  before do
    @genre = FactoryBot.create(:genre)
  end

  context "バリデーションチェック" do
    it "有効な投稿内容の場合は保存されるか" do
      expect(@genre).to be_valid
    end
    it "nameが空欄でないこと" do
      @genre.name = ''
      @genre.valid?
      expect(@genre.errors.full_messages).to include "タグ名を入力してください"
    end
    it "nameが一意である" do
      Genre.create(
        name: "genre"
      )
      @genre = Genre.new(
        name: "genre",
      )
      @genre.valid?
      expect(@genre.valid?).to eq(false)
    end
  end

  describe 'アソシエーションのテスト' do
    context 'itemモデルとの関係' do
      it '1:Nとなっている' do
        expect(Genre.reflect_on_association(:items).macro).to eq :has_many
      end
    end

    context 'tagモデルとの関係' do
      it '1:Nとなっている' do
        expect(Genre.reflect_on_association(:tags).macro).to eq :has_many
      end
    end
  end
end
