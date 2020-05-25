class Story < ApplicationRecord
    mount_uploader :image, ImageUploader
end
