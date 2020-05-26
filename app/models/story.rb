class Story < ApplicationRecord
    validates :title, presence: true
    validates :thumbnail_image, presence: true
    
    mount_uploader :thumbnail_image, ImageUploader
    has_many :parts, dependent: :destroy
    accepts_nested_attributes_for :parts, reject_if: :reject_both_blank, allow_destroy: true
    belongs_to :user
    validates :parts, presence: true

    def reject_both_blank(attributes)
        if attributes[:id]
            attributes.merge!(_destroy: "1") if attributes[:text].blank? and attributes[:image].blank?
            !attributes[:text].blank? and attributes[:image].blank?
        else
            attributes[:text].blank? and attributes[:image].blank?
        end
    end
end