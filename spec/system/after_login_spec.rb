require 'rails_helper'

describe '会員ログイン後のテスト' do
    let(:user) { create(:user) }
    before do
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('app/assets/images/no_image.jpeg')
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログインする'
    end
   
    describe 'ログインしている場合のヘッダーのテスト※logoutは『ユーザログアウトのテスト』でテスト済みになります。' do
        
    
        context 'ヘッダーの表示内容が正しい' do
          it 'ロゴリンクを押したらトップページに戻る' do
            page.first(".logo").click
            expect(current_path).to eq '/'
          end
          it '通知のリンクが表示される' do
            expect(page).to have_selector '#bell'
          end
          it 'お問い合わせボタンのリンクが表示される' do
            expect(page).to have_link 'お問い合わせ', href: '/inquiries'
          end
          it 'タグ一覧ボタンのリンクが表示される' do
            expect(page).to have_link 'タグ一覧', href: '/searches/tag_lists'
          end
          it 'お気に入り品ボタンが表示される' do
            expect(page).to have_link 'お気に入り品', href: '/users/' + user.id.to_s + '/favorites'
          end
          it '売り上げデータボタンが表示される' do
            expect(page).to have_link '売り上げデータ', href: '/users/' + user.id.to_s + '/datas'
          end
          it '購入履歴ボタンのリンクが表示される' do
            expect(page).to have_link '購入履歴', href: '/purchases'
          end
          it 'マイページボタンのリンクが表示される' do
            expect(page).to have_link 'マイページ', href: '/users/' + user.id.to_s
          end
          it 'ログアウトボタンのリンクが表示される' do
            expect(page).to have_link 'ログアウト', href: '/users/sign_out'
          end
        end
    end
    
    describe 'トップ画面のテスト' do
        before do
            visit root_path
        end
        
        context '表示内容の確認' do
            it 'URLが正しい' do
                expect(current_path).to eq '/'
            end
            it '商品画像のリンク先が正しい' do
            expect(page).to have_selector("img[src$='no_image.jpeg']"),href: '/items/' + @item.id.to_s
            end
        end
    end
    
    describe '会員の詳細画面' do
        before do
            click_link 'マイページ'
        end
        
        context '表示内容の確認' do
            it 'URLが正しい' do
             expect(current_path).to eq '/users/' + user.id.to_s
            end
            it 'プロフィール画面の編集ボタンのリンク先が正しい' do
              expect(page).to have_link 'プロフィールを編集する', href: '/users/' + user.id.to_s + '/edit'
            end
            it 'フォロー人数を押した時のリンク先が正しい' do
              expect(page).to have_link user.following_user.count,href: '/users/' + user.id.to_s + '/follows'
            end
            it 'フォロワー人数を押した時のリンク先が正しい' do
              expect(page).to have_link user.follower_user.count,href: '/users/' + user.id.to_s + '/followers'
            end
            it '出品ボタンを押した時のリンク先が正しい' do
            find(".item_new").click
            expect(current_path).to eq '/items/new'
            end
            it '商品画像のリンク先が正しい' do
            expect(page).to have_selector("img[src$='no_image.jpeg']"),href: '/items/' + @item.id.to_s
            end
        end
    end
    
    describe '会員の情報編集ができているか' do
        before do
            visit edit_user_path(user)
        end
        context '表示内容の確認' do 
            it 'URLが正しい' do
            expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
            end
            it '名前編集フォームに自分の姓が表示される' do
            expect(page).to have_field 'user[last_name]',with: user.last_name
            end
            it '名前編集フォームに自分の名が表示される' do
            expect(page).to have_field 'user[first_name]',with: user.first_name
            end
            it '名前編集フォームに自分のフリガナ(セイ)が表示される' do
            expect(page).to have_field 'user[last_name_kana]',with: user.last_name_kana
            end
            it '名前編集フォームに自分のフリガナ(メイ)が表示される' do
            expect(page).to have_field 'user[first_name_kana]',with: user.first_name_kana
            end
            it '郵便番号フォームが表示される' do
            expect(page).to have_field 'user[postal_code]',with: user.postal_code
            end
            it '住所フォームが表示される' do
            expect(page).to have_field 'user[address]',with: user.address
            end
            it '電話番号フォームが表示される' do
            expect(page).to have_field 'user[telephone_number]',with: user.telephone_number
            end
            it 'ニックネームフォームが表示される' do
            expect(page).to have_field 'user[name]'
            end
            it '画像の選択ボタンが表示される' do
            expect(page).to have_field 'user[image]'
            end
            it 'プロフィール画像が表示される' do
            expect(page).to have_selector("img[src$='no_image.jpeg']")
            end
            it 'プロフィールフォームと内容が表示される' do
            expect(page).to have_field 'user[profile]'
            end
            it '会員情報を変更するが表示される' do
            expect(page).to have_button '会員情報を変更する'
            end
            it '退会するリンクが表示される' do
            expect(page).to have_link '退会する',href: '/users/unsubscribe'
            end
        end
        
        context '会員情報の変更に成功した際の処理' do
        before do
        @user_old_last_name = user.last_name
        @user_old_first_name = user.first_name
        @user_old_last_name_kana = user.last_name_kana
        @user_old_first_name_kana = user.first_name_kana
        @user_old_postal_code = user.postal_code
        @user_old_address = user.address
        @user_old_telephone_number = user.telephone_number
        @user_old_image = attach_file 'user[image]', "#{Rails.root}/spec/factories/images/no_image.jpeg"
        fill_in 'user[last_name]', with: Faker::Lorem.characters(number: 5) 
        fill_in 'user[first_name]', with: Faker::Lorem.characters(number: 5) 
        fill_in 'user[last_name_kana]', with: Gimei.name.katakana
        fill_in 'user[first_name_kana]', with: Gimei.name.katakana
        fill_in 'user[postal_code]', with: 8910111
        fill_in 'user[address]', with: Faker::Lorem.characters(number: 5) 
        fill_in 'user[telephone_number]', with: '0906543531'
        attach_file 'user[image]', "#{Rails.root}/spec/factories/images/ロゴ.png"
        click_button '会員情報を変更する'
        end
        
        it '名前(姓)が正しく更新される' do
        expect(user.reload.last_name).not_to eq @user_old_last_name
        end
        it '名前(名)が正しく更新される' do
        expect(user.reload.first_name).not_to eq @user_old_first_name
        end
        it 'フリガナ(セイ)が正しく更新される' do
        expect(user.reload.last_name_kana).not_to eq @user_old_last_name_kana
        end
        it 'フリガナ(メイ)が正しく更新される' do
        expect(user.reload.first_name_kana).not_to eq @user_old_first_name_kana
        end
        it '郵便番号が正しく更新される' do
        expect(user.reload.postal_code).not_to eq @user_old_postal_code
        end
        it '住所が正しく更新される' do
        expect(user.reload.address).not_to eq @user_old_address
        end
        it '電話番号が正しく更新される' do
        expect(user.reload.telephone_number).not_to eq @user_old_telephone_number
        end
        it 'プロフィール画像が正しく更新される' do
        expect(user.reload.image).not_to eq @user_old_image
        end
        it 'リダイレクト先が、自分のユーザ詳細画面になっている' do
        expect(current_path).to eq '/users/' + user.id.to_s
        end   
        end
        
        context '退会画面の表示内容が正しいか' do
        before do
        click_link '退会する'
        end
        it 'URLが正しい' do
        expect(current_path).to eq '/users/unsubscribe'
        end
        it '退会するボタンのリンク先が正しい' do
        expect(page).to have_link '退会する'
        click_link '退会する'
        expect(current_path).to eq '/'
        end
        it '退会しないボタンのリンク先が正しい' do
        expect(page).to have_link '退会しない'
        click_link '退会しない'
        expect(current_path).to eq '/users/' + user.id.to_s 
        end
        end
        
        context '退会処理が実行できているか' do
        before do
        click_link '退会する'
        click_link '退会する'
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: 'password'
        click_button 'ログインする'
        end
        
        it 'ログインできずにログインページに戻る' do
        expect(current_path).to eq "/users/sign_in"
        end
        
        end
    end
    
    describe '商品を出品できるか' do
        before do
            click_link(".item_new")
            visit items_new_path
        end
        context '表示内容の確認' do
        it 'URLが正しい' do
            expect(current_path).to eq '/items/new'
         end
          it '画像の選択ボタンが表示される' do
            expect(page).to have_field 'item[image]'
          end
          it '商品名のフォームが表示される' do
            expect(page).to have_field 'item[name]'
          end
          it '商品金額のフォームが表示される' do
            expect(page).to have_field 'item[price]'
          end
          it '商品説明のフォームが表示される' do
            expect(page).to have_field 'item[introduction]'
          end
          it 'タグのフォームが表示される' do
            expect(page).to have_field 'item[genre_ids]'
          end
          it '新規登録ボタンが表示される' do
            expect(page).to have_link '商品を出品する'
          end
        end
    end
    
    
    
end