require 'rails_helper'

RSpec.describe 'adminモデルのテスト', type: :model do
  before do
    @admin=FactoryBot.create(:admin)
  end
  context "バリデーションチェック" do
   it "有効なログイン内容の場合は保存されるか" do
    expect(@admin).to be_valid
   end
   it "emailが空欄でないこと" do
    @admin.email = ''
    @admin.valid?
    expect(@admin.valid?).to eq(false)
   end
   it 'emailが一意であること' do
    Admin.create(
    email: "admin"
    )
    @admin = Admin.new(
    email: "admin",
    )
    @admin.valid?
    expect(@admin.valid?).to eq(false)
   end
   it "passwordが空欄でないこと" do
    @admin.password = ''
    @admin.valid?
    expect(@admin.valid?).to eq(false)
   end
   it "password_confirmationが空欄でないこと" do
    @admin.password_confirmation = ''
    @admin.valid?
    expect(@admin.valid?).to eq(false)
   end
  end

end