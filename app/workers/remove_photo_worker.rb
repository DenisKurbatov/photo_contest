class RemovePhotoWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(photo_id)
    photo = Photo.find(photo_id)
    return unless photo.removed?
    photo.destroy
  end
end
