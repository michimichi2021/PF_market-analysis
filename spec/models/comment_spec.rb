require 'rails_helper'

RSpec.describe 'commentモデルのテスト', type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  context "バリデーションチェック" do
    it "有効な投稿内容の場合は保存されるか" do
      expect(@comment).to be_valid
    end
    it "コメントが空欄でないこと" do
      @comment.comment = ''
      @comment.valid?
      expect(@comment.valid?).to eq(false)
    end
  end

  describe 'アソシエーションのテスト' do
    context 'itemモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:item).macro).to eq :belongs_to
      end
    end

    context 'userモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
