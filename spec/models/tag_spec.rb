require 'rails_helper'

RSpec.describe 'tagモデルのテスト', type: :model do
  before do
    @tag = FactoryBot.build(:tag)
  end

  context "バリデーションチェック" do
    it "有効な投稿内容の場合は保存されるか" do
      expect(@tag).to be_valid
    end
  end
end
