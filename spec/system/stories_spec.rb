require 'rails_helper'
require 'selenium-webdriver'
RSpec.describe 'Story 管理機能', type: :system do
  before do
    @user = create(:user)
    # @admin_user = create(:admin_user)
    # @part = create(:part)
    # @story = create(:story)
    # let!(:story) { FactoryBot.create(:post_with_part) 
    # @second_story = create(:second_story)
  end

  describe 'Story一覧画面' do
    context 'Storyを作成した場合' do
      it '作成済みのタスクが表示される' do
        visit user_session_path
        fill_in 'user[email]', with: 'test1@example.com'
        fill_in 'user[password]', with: '111111'
        click_button 'ログイン'
        visit stories_path
        expect(page).to have_content 'Story一覧'
      end
    end
  end

  describe 'Story登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit user_session_path
        fill_in 'user[email]', with: 'test1@example.com'
        fill_in 'user[password]', with: '111111'
        click_button 'ログイン'
        click_on 'New'
        visit new_story_path
        fill_in 'story[title]', with: 'タイトル3'
        attach_file 'story[thumbnail_image]', "#{Rails.root}/db/fixtures/1.jpeg"
        fill_in 'story_parts_attributes_0_text', with: 'テキスト3'
        attach_file 'story_parts_attributes_0_image', "#{Rails.root}/db/fixtures/1.jpeg"
        click_on '登録する'
        expect(page).to have_content 'テキスト3'
      end
    end
  end
  describe 'Story詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移する' do
        visit user_session_path
        fill_in 'user[email]', with: 'test1@example.com'
        fill_in 'user[password]', with: '111111'
        click_button 'ログイン'
        click_on 'New'
        visit new_story_path
        fill_in 'story[title]', with: 'タイトル5'
        attach_file 'story[thumbnail_image]', "#{Rails.root}/db/fixtures/1.jpeg"
        fill_in 'story_parts_attributes_0_text', with: 'テキスト5'
        attach_file 'story_parts_attributes_0_image', "#{Rails.root}/db/fixtures/1.jpeg"
        click_on 'Storyを追加'        
        click_on '登録する'
        expect(page).to have_content 'テキスト5'
      end
    end
  end
end
