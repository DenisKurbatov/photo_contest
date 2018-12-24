module Photos
  class Create < ActiveInteraction::Base
    string :name
    file :image
    integer :user_id, base: 10

    validates :user_id, :name, :image, presence: true
    validate :name_uniquenes?


    def to_model
      Photo.new
    end

    def execute
      photo = Photo.new(inputs)
      errors.merge!(photo.errors) unless photo.save!
      photo
    end

    private

    def name_uniquenes?
      errors.add(:uniquenes, 'photo with the same name exists. Please enter another photo') if Photo.where(name: name).exists?
    end
  end
end
