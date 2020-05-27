require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do
  before do
    @user = FactoryBot.create(:user)
  end
  it 'titleが空ならバリデーションが通らない' do
    story = Story.new(title: '')
    expect(story).not_to be_valid
  end
  it 'titleに内容が記載されていればバリデーションが通る' do
    story = Story.new(title: '成功テスト2', user: @user)
    expect(story).to be_valid
  end
end
