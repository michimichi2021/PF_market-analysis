require 'rails_helper'

RSpec.describe '商品の投稿テスト', type: :system do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('app/assets/images/no_image.jpeg')
    @user = FactoryBot.build(:user)
  end
  
end