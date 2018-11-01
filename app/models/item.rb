class Item < ApplicationRecord
    self.per_page = 10
    acts_as_taggable

    has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment :picture, presence: true
    do_not_validate_attachment_file_type :picture

    validates :name, presence: true
    validates :tag_list, presence: true
    validate :tag_list_inclusion, on: :create


    # definately here should be used regex
    def tag_list_inclusion
        tag_list.each do |tag|
        errors.add(tag," + -  chars in tag are not valid") if validate_tags(tag)
        end
    end

    def validate_tags(tag)
        if tag.include?('+') || tag.include?('-')
            true
        else
            false
        end    
    end

end
