require 'rails_helper'

describe '会員ログイン前のテスト' do
  describe 'トップページのテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
    end
  end

  describe 'お問い合わせページのテスト' do
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
        fill_in 'inquiry[email]', with: ''
        fill_in 'inquiry[name]', with: ''
        click_button '確認'
        expect(current_path).to eq '/inquiries/confirm'
        expect(page).to have_content '入力内容にエラーがあります'
        expect(page).to have_content '名前を入力してください'
        expect(page).to have_content 'メールアドレスを入力してください'
      end
      it '確認ボタン後のリダイレクト先は正しいか' do
        fill_in 'inquiry[name]', with: Faker::Lorem.characters(number: 5)
        fill_in 'inquiry[email]', with: Faker::Internet.email
        fill_in 'inquiry[message]', with: Faker::Lorem.characters(number: 20)
        click_button '確認'
        expect(page).to have_current_path inquiries_confirm_path
      end
    end

    context 'お問い合わせ内容を送信する際の処理' do
      let(:inquiry) { build(:inquiry) }

      before do
        fill_in 'inquiry[name]', with: inquiry.name
        fill_in 'inquiry[email]', with: inquiry.email
        fill_in 'inquiry[message]', with: inquiry.message
        click_button '確認'
      end

      it '送信ボタン後のリダイレクト先は正しいか' do
        expect(page).to have_content inquiry.name
        expect(page).to have_content inquiry.email
        expect(page).to have_content inquiry.message
        click_button '送信'
        expect(page).to have_current_path inquiries_thanks_path
      end
    end
  end

  describe 'タグ一覧ページのテスト' do
    let!(:genre) { create(:genre) }

    before do
      visit searches_tag_lists_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/searches/tag_lists'
      end
      it 'タグの一覧が表示されているか' do
        expect(page).to have_content genre.name
      end
      it 'タグを押した後の表示先は正しいか' do
        expect(page).to have_link genre.name, href: searches_search_tag_path(genre_id: genre.id)
      end
    end
  end

  describe 'ログインしていない場合のヘッダーのテスト' do
    before do
      visit root_path
    end

    context '表示内容のリンク先が正しいか' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'ロゴリンクを押したらトップページに戻る' do
        page.first(".logo").click
        expect(current_path).to eq '/'
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

    context '新規登録の送信に成功した際の処理' do
      before do
        fill_in 'user[last_name]', with: Faker::Lorem.characters(number: 5)
        fill_in 'user[first_name]', with: Faker::Lorem.characters(number: 5)
        fill_in 'user[last_name_kana]', with: Gimei.name.katakana
        fill_in 'user[first_name_kana]', with: Gimei.name.katakana
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[postal_code]', with: 1234567
        fill_in 'user[address]', with: Faker::Address
        fill_in 'user[telephone_number]', with: '090654321'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        attach_file 'user[image]', "#{Rails.root}/spec/factories/images/no_image.jpeg"
      end

      it '新規登録ボタンを押したら、登録できるか' do
        expect { click_button '新規登録' }.to change(User.all, :count).by(1)
      end
      it '新規登録ボタンを押した後の、リダイレクト先は正しいか' do
        click_button '新規登録'
        expect(current_path).to eq "/"
      end
    end
  end

  describe 'ユーザログインのテスト' do
    let(:user) { create(:user) }

    context '表示内容の確認' do
      before do
        visit new_user_session_path
      end

      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'パスワードフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'ログインするボタンが表示される' do
        expect(page).to have_button 'ログインする'
      end
      it 'ログインページへののリンクが表示される' do
        expect(page).to have_link 'こちら', href: '/users/sign_up'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: 'password'
        click_button 'ログインする'
      end

      it 'ログイン後のリダイレクト先がトップページになっている' do
        expect(current_path).to eq "/"
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログインする'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  describe 'ユーザログアウトのテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログインする'
    end

    it 'ログアウト後のリダイレクト先がトップページになっている' do
      click_link 'ログアウト'
      expect(current_path).to eq "/"
    end
  end
end
