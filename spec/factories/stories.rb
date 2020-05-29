FactoryBot.define do
  factory :story do
    title { 'タイトル1' }
    thumbnail_image { File.new("#{Rails.root}/db/fixtures/1.jpeg") }
    user
  end

  factory :second_story, class: Story do
    title { 'タイトル2' }
    thumbnail_image { File.new("#{Rails.root}/db/fixtures/2.jpeg") }
    user
  end
end
