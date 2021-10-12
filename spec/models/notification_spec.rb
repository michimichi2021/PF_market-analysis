require 'rails_helper'

RSpec.describe 'notificationモデルのテスト', type: :model do
  describe '通知が保存されるか' do
    context '商品に関する通知' do
      before do
        @user = FactoryBot.build(:user)
        @item = FactoryBot.build(:item)
        @comment = FactoryBot.build(:comment)
      end

      it 'いいねされた際に通知が保存される' do
        notification = FactoryBot.build(:notification, item_id: @item.id, visited_id: @user.id, action: "like")
        expect(notification).to be_valid
      end
      it "コメントに対して返信が行われた際に通知が保存される" do
        notification = FactoryBot.build(:notification, comment_id: @comment.id, visited_id: @user.id, action: "comment")
        expect(notification).to be_valid
      end
      it '購入された際に通知が保存される' do
        notification = FactoryBot.build(:notification, item_id: @item.id, visited_id: @user.id, action: "purchase")
        expect(notification).to be_valid
      end
    end

    context "フォローに関する通知" do
      it "フォローが行われた際に保存できる" do
        user1 = FactoryBot.build(:user)
        user2 = FactoryBot.build(:user)
        notification = FactoryBot.build(:notification, visiter_id: user1.id, visited_id: user2.id, action: "follow")
        expect(notification).to be_valid
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'userモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:visiter).macro).to eq :belongs_to
        expect(Notification.reflect_on_association(:visited).macro).to eq :belongs_to
      end
    end

    context 'commentモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:comment).macro).to eq :belongs_to
      end
    end

    context 'itemモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:item).macro).to eq :belongs_to
      end
    end
  end
end
