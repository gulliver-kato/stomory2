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
        visit new_user_registration_path
        fill_in 'user[name]', with: 'test3'
        fill_in 'user[nickname]', with: 'nick_test3'
        fill_in 'user[age]', with: '33'
        select '男性', from: 'user_gender'
        select '既婚', from: 'user_maritalstatus'
        select '東京都', from: 'user_prefecture'
        fill_in 'user[email]', with: 'test3@example.com'
        fill_in 'user[password]', with: '333333'
        fill_in 'user[password_confirmation]', with: '333333'
        click_button 'アカウント登録'
        expect(page).to have_content 'みんなのストーリーをチェックしよう'
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
        visit user_session_path
        fill_in 'user[email]', with: 'test1@example.com'
        fill_in 'user[password]', with: '111111'
        click_button 'ログイン'
        expect(page).to have_content 'Story一覧'
      end
      it '他人のマイページに飛ぶとタスク一覧ページに遷移するテスト' do
        visit user_session_path
        fill_in 'user[email]', with: 'test1@example.com'
        fill_in 'user[password]', with: '111111'
        click_button 'ログイン'
        visit user_path(@admin_user.id)
        expect(page).to have_content 'test1@example.com'
      end
    end
    context 'ユーザーがログインしている場合' do
      it 'セッションログアウトのテスト' do
        visit user_session_path
        fill_in 'user[email]', with: 'test1@example.com'
        fill_in 'user[password]', with: '111111'
        click_button 'ログイン'
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '管理画面のテスト' do
    context '管理者がいる状態' do
      it '管理者が管理画面にアクセスできるテスト' do
        visit user_session_path
        fill_in 'user[email]', with: 'admin@example.com'
        fill_in 'user[password]', with: '000000'
        click_button 'ログイン'
        visit rails_admin_path
        expect(page).to have_content 'サイト管理'
      end
      it '一般ユーザーが管理画面にアクセスできないテスト' do
        visit user_session_path
        fill_in 'user[email]', with: 'test1@example.com'
        fill_in 'user[password]', with: '111111'
        click_button 'ログイン'
        visit rails_admin_path
        expect(page).to have_content 'Story一覧'
      end
      it '管理者がユーザーの詳細画面にアクセスできるテスト' do
        visit user_session_path
        fill_in 'user[email]', with: 'admin@example.com'
        fill_in 'user[password]', with: '000000'
        click_button 'ログイン'
        visit rails_admin_path
        click_on 'ユーザー', match: :first
        sleep 1
        click_on '詳細', match: :first
        expect(page).to have_content 'admin'
        expect(page).to have_content 'admin@example.com'
      end
      it '管理者がユーザーの編集画面からユーザーを編集できるテスト' do
        visit user_session_path
        fill_in 'user[email]', with: 'admin@example.com'
        fill_in 'user[password]', with: '000000'
        click_button 'ログイン'
        visit rails_admin_path
        click_on 'ユーザー', match: :first
        sleep 1
        click_on '編集', match: :first
        fill_in 'user[name]', with: 'test5'
        fill_in 'user[password]', with: '111111'
        click_on '保存', match: :first
        expect(page).to have_content 'ユーザーの一覧'
      end
      it '管理者がユーザーの削除ができるテスト' do
        visit user_session_path
        fill_in 'user[email]', with: 'admin@example.com'
        fill_in 'user[password]', with: '000000'
        click_button 'ログイン'
        visit rails_admin_path
        click_on 'ユーザー', match: :first
        sleep 1
        click_on '削除', match: :first
        click_on '実行する', match: :first
        expect(page).to have_content 'ユーザーの一覧'
      end
    end
  end
end