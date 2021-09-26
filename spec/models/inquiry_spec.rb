require 'rails_helper'

RSpec.describe 'inquiryモデルのテスト', type: :model do
  before do
    @inquiry = FactoryBot.build(:inquiry)
  end

  context "バリデーションチェック" do
    it "有効なname,emailの場合は送信されるか" do
      expect(@inquiry).to be_valid
    end
    it "nameが空欄でないこと" do
      @inquiry.name = ''
      @inquiry.valid?
      expect(@inquiry.errors.full_messages).to include "Name名前を入力してください"
    end
    it "emailが空欄でないこと" do
      @inquiry.email = ''
      @inquiry.valid?
      expect(@inquiry.errors.full_messages).to include "Emailメールアドレスを入力してください"
    end
  end
end
