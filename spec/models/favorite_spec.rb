require 'rails_helper'

RSpec.describe 'favoriteモデルのテスト', type: :model do
  before do
  @favorite = FactoryBot.build(:favorite)
  end
  describe 'アソシエーションのテスト' do
  context 'itemモデルとの関係' do
    it 'N:1となっている' do
      expect(Favorite.reflect_on_association(:item).macro).to eq :belongs_to
    end
  end
  context 'userモデルとの関係' do
    it 'N:1となっている' do
      expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
    end
  end
end
  
end