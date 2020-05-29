require 'rails_helper'

RSpec.describe 'ユーザーモデル機能', type: :model do
  it 'nameが空ならバリデーションに通らない' do
    user = User.new(name: '', nickname: 'ニックネーム', age: '35', gender: '男性',email: 'test@email.com', password: '000000')
    expect(user).not_to be_valid
  end
  it 'nicknameが空ならバリデーションに通らない' do
    user = User.new(name: '名前', nickname: '', age: '35', gender: '男性',email: 'test@email.com', password: '000000')
    expect(user).not_to be_valid
  end
  it '年齢が5歳未満ならバリデーションに通らない' do
    user = User.new(name: '名前', nickname: 'ニックネーム', age: '４', gender: '男性',email: 'test@email.com', password: '000000')
    expect(user).not_to be_valid
  end
  it 'nicknameが空ならバリデーションに通らない' do
    user = User.new(name: '名前', nickname: 'ニックネーム', age: '15', gender: '',email: 'test@email.com', password: '000000')
    expect(user).not_to be_valid
  end
  it 'emailが空ならバリデーションに通らない' do
    user = User.new(name: '名前', nickname: 'ニックネーム', age: '15', gender: '男性',email: '', password: '000000')
    expect(user).not_to be_valid
  end
  it 'パスワードが５文字以下ならバリデーションに通らない' do
    user = User.new(name: '名前', nickname: 'ニックネーム', age: '15', gender: '男性',email: 'est@email.com', password: '00000')
    expect(user).not_to be_valid
  end
end