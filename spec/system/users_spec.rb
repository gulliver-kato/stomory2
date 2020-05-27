require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do
  before do
    @admin_user = create(:admin_user)
    @user = create(:user)
    # @second_user = create(:second_user)
  end

  describe 'ユーザ登録のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it 'ユーザ新規登録のテスト' do
        visit new_user_path
        fill_in 'user[name]', with: 'test3'
        fill_in 'user[nickname]', with: 'nick_test3'
        fill_in 'user[age]', with: '33'
        select '男性', from: 'user_gender'
        select '既婚', from: 'user_maritalstatus'
        # select 'Japan', from: 'user_country'
        select '東京都', from: 'user_prefecture'
        fill_in 'user[email]', with: 'test3@example.com'
        fill_in 'user[password]', with: '333333'
        fill_in 'user[password_confirmation]', with: '333333'
        click_button 'Create my account'
        expect(page).to have_content 'test3'
        expect(page).to have_content 'test3@example.com'
      end
      it 'ログインしていない時はログイン画面に飛ぶテスト' do
        visit mystory_stories_path
        expect(current_path).to eq root_path
      end
    end
  end

  describe 'セッション機能のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it 'セッションログインのテスト' do
        visit new_session_path
        fill_in 'session[email]', with: 'test1@example.com'
        fill_in 'session[password]', with: '111111'
        click_button 'log in'
        expect(page).to have_content 'test1@example.com'
      end
      it '他人のマイページに飛ぶとタスク一覧ページに遷移するテスト' do
        visit new_session_path
        fill_in 'session[email]', with: 'test1@example.com'
        fill_in 'session[password]', with: '111111'
        click_button 'log in'
        visit user_path(@admin_user.id)
        expect(current_path).to eq root_path
      end
    end
    context 'ユーザーがログインしている場合' do
      it 'セッションログアウトのテスト' do
        visit new_session_path
        fill_in 'session[email]', with: 'test1@example.com'
        fill_in 'session[password]', with: '111111'
        click_button 'log in'
        click_link 'logout'
        expect(current_path).to eq new_session_path
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '管理画面のテスト' do
    context '管理者がいる状態' do
      it '管理者が管理画面にアクセスできるテスト' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: '000000'
        click_button 'log in'
        visit admin_users_path
        expect(page).to have_content 'User Lists'
      end
      it '一般ユーザーが管理画面にアクセスできないテスト' do
        visit new_session_path
        fill_in 'session[email]', with: 'test1@example.com'
        fill_in 'session[password]', with: '111111'
        click_button 'log in'
        visit admin_users_path
        expect(current_path).to eq root_path
      end
      it '管理者がユーザーの新規登録ができるテスト' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: '000000'
        click_button 'log in'
        visit new_admin_user_path
        fill_in 'user[name]', with: 'test4'
        fill_in 'user[nickname]', with: 'nick_test1'
        fill_in 'user[age]', with: '33'
        select '男性', from: 'user_gender'
        select '既婚', from: 'user_maritalstatus'
        # select 'Japan', from: 'user_country'
        select '東京都', from: 'user_prefecture'
        fill_in 'user[email]', with: 'test4@example.com'
        fill_in 'user[password]', with: '444444'
        fill_in 'user[password_confirmation]', with: '444444'
        click_button 'Create my account'
        expect(current_path).to eq admin_users_path
      end
      it '管理者がユーザーの詳細画面にアクセスできるテスト' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: '000000'
        click_button 'log in'
        visit admin_user_path(@admin_user.id)
        expect(page).to have_content 'admin'
        expect(page).to have_content 'admin@example.com'
      end
      it '管理者がユーザーの編集画面からユーザーを編集できるテスト' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: '000000'
        click_button 'log in'
        visit edit_admin_user_path(@user.id)
        fill_in 'user[name]', with: 'test5'
        fill_in 'user[password]', with: '111111'
        click_button 'Edit my account'
        expect(current_path).to eq admin_users_path
      end
      it '管理者がユーザーの削除ができるテスト' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: '000000'
        click_button 'log in'
        visit admin_users_path
        page.accept_confirm do
          click_on 'Destroy', match: :first
        end
        expect(current_path).to eq admin_users_path
      end
    end
  end
end