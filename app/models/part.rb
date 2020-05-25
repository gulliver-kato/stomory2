class Part < ApplicationRecord
    belongs_to :story, optional: true
    mount_uploader :image, ImageUploader
    validates :text, presence: true
    validates :image, presence: true
end