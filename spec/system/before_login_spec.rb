require 'rails_helper'

describe '会員ログイン前のテスト' do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('app/assets/images/no_image.jpeg')
  end
  describe 'トップページのテスト' do
    before do
      visit root_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it '商品画像の表示' do
        # expect(page).to have_selector("css img[src$='img.png']")
      end
    end
  end
  describe 'お問い合わせページのテスト' do
    let(:inquiry) { create(:inquiry) }
    before do
      visit inquiries_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/inquiries'
      end
      it 'お問い合わせフォームが表示されているか' do
        expect(page).to have_field 'inquiry[name]'
        expect(page).to have_field 'inquiry[email]'
        expect(page).to have_field 'inquiry[message]'
      end
      it 'お問い合わせ内容の確認ボタンが表示されているか' do
        expect(page).to have_button '確認'
      end
    end
    context 'お問い合わせ内容を確認する際の処理' do
      it 'お問い合わせ内容の確認に失敗する' do
        click_button '確認'
        # expect(page).to have_content 'error'
        expect(current_path).to eq '/inquiries'
      end
      it '確認ボタン後のリダイレクト先は正しいか' do
        fill_in 'inquiry[name]',with:Faker::Lorem.characters(number: 5)
        fill_in 'inquiry[email]',with:Faker::Internet.email
        fill_in 'inquiry[message]',with:Faker::Lorem.characters(number: 20)
        click_button '確認'
        expect(page).to have_current_path  inquiries_confirm_path
      end
    end
    context 'お問い合わせ内容を送信する際の処理'do
      it '送信ボタン後のリダイレクト先は正しいか'  do
        expect(page).to have_content inquiry.name
        expect(page).to have_content inquiry.email
        expect(page).to have_content inquiry.message
        click_button '送信'
        expect(page).to have_current_path  inquiries_thanks_path
      end
    end
  end
  
  describe 'タグ一覧ページのテスト' do
    let!(:genre) { create(:genre) }
    before do
      visit  searches_tag_lists_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/searches/tag_lists'
      end
      it 'タグの一覧が表示されているか' do
        expect(page).to have_content genre.name
      end
      it 'タグを押した後の表示先は正しいか' do
        # expect(page).to have_link genre.name, href: searches_search_tag_path(tag)
      end
    end
  end
  
  describe 'タグ検索商品一覧ページのテスト' do
    let!(:genre) { create(:genre) }
    before do
      visit  searches_search_tag_path(genre)
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        # expect(current_path).to eq '/searches/search_tag' + genre.id.to_s
      end
      it 'タグを押した後の表示先は正しいか' do
        # expect(page).to have_link genre.item.name, href: searches_search_tag_path(tag)
      end
    end
  end
  
  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'トップページへのロゴのリンクが表示される' do
        # expect(page).to have_selector "img[src$='パンプキン (1).png']"
      end
      it 'お問い合わせボタンのリンクが表示される' do
        expect(page).to have_link 'お問い合わせ', href: '/inquiries'
      end
      it 'タグ一覧ボタンのリンクが表示される' do
        expect(page).to have_link 'タグ一覧', href: '/searches/tag_lists'
      end
      it '新規登録ボタンのリンクが表示される' do
        expect(page).to have_link '新規登録', href: '/users/sign_up'
      end
      it 'ログインボタンのリンクが表示される' do
        expect(page).to have_link 'ログイン', href: '/users/sign_in'
      end
    end
  end
  
  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_user_registration_path
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it '新規会員登録と表示されている' do
        expect(page).to have_content '新規会員登録'
      end
      it '名前(姓)フォームが表示される' do
        expect(page).to have_field 'user[last_name]'
      end
      it '名前(名)フォームが表示される' do
        expect(page).to have_field 'user[first_name]'
      end
      it 'フリガナ(セイ)フォームが表示される' do
        expect(page).to have_field 'user[last_name_kana]'
      end
      it 'フリガナ(メイ)フォームが表示される' do
        expect(page).to have_field 'user[first_name_kana]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it '郵便番号フォームが表示される' do
        expect(page).to have_field 'user[postal_code]'
      end
      it '住所フォームが表示される' do
        expect(page).to have_field 'user[address]'
      end
      it '電話番号フォームが表示される' do
        expect(page).to have_field 'user[telephone_number]'
      end
      it 'パスワードフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'パスワード確認用が表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it '画像の選択ボタンが表示される' do
        expect(page).to have_field 'user[image]'
      end
      it '新規登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
      it 'ログインページへののリンクが表示される' do
        expect(page).to have_link 'こちら', href: '/users/sign_in'
      end
    end
    context '新規登録情報を送信する際の処理' do
      it '送信に失敗する' do
        click_button '新規登録'
        expect(page).to have_content 'error'
        expect(current_path).to eq '/users/sign_up'
      end
      it '確認ボタン後のリダイレクト先は正しいか' do
        fill_in 'user[last_name]',with:Faker::Lorem.characters(number: 5)
        fill_in 'user[first_name]',with:Faker::Lorem.characters(number: 5)
        fill_in 'user[last_name_kana]',with:person.last.katakana
        fill_in 'user[first_name_kana]',with:person.first.katakana
        fill_in 'user[email]',with:Faker::Internet.email
        fill_in 'user[postal_code]',with:1234567
        fill_in 'user[address]',with:Faker::Address
        fill_in 'user[telephone_number]',with:'090654321'
        fill_in 'user[password]',with:password
        fill_in 'user[password_confirmation]',with:password_confirmation
        fill_in 'user[image]',with:image
      end
    end
  end
  
  
end