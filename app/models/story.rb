class Story < ApplicationRecord
    validates :title, presence: true
    validates :thumbnail_image, presence: true
    
    mount_uploader :thumbnail_image, ImageUploader
    has_many :parts, dependent: :destroy
    validates :parts, presence: true
    accepts_nested_attributes_for :parts, allow_destroy: true, reject_if: :reject_both_blank
    belongs_to :user
    

    def reject_both_blank(attributes)
        if attributes[:text].blank? && attributes[:image].blank?
            if self.parts.where(id: attributes[:id]).present?
                !attributes[:text].blank? and attributes[:image].blank?
            else
                attributes.merge!(_destroy: "1")
                !attributes[:text].blank? and attributes[:image].blank?
            end
        else
            attributes[:text].blank? and attributes[:image].blank?
        end
    end
end