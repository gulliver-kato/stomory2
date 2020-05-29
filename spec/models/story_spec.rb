require 'rails_helper'

RSpec.describe 'Story管理機能', type: :model do
  before do
    @user = FactoryBot.create(:user)
  end
  it 'titleが空ならバリデーションが通らない' do
    story = Story.new(title: '', thumbnail_image: '#{Rails.root}/db/fixtures/2.jpeg') 
    expect(story).not_to be_valid
  end
  it '表紙画像が空ならバリデーションが通らない' do
    story = Story.new(title: 'タイトル', thumbnail_image: '') 
    expect(story).not_to be_valid
  end
  it 'partが空ならバリデーションが通らない' do
    story = Story.new(title: 'タイトル', thumbnail_image: '#{Rails.root}/db/fixtures/2.jpeg', parts: [])
    expect(story).not_to be_valid
  end
end
