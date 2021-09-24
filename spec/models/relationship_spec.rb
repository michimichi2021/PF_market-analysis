require 'rails_helper'

RSpec.describe 'relationshipモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'userモデルとの関係' do
      it 'N:1となっている' do
        expect(Relationship.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
