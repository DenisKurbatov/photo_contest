class RemovePhotoWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(photo_id)
    photo = Photo.find(photo_id)
    if photo.removed?
      PastState.remove_member(photo_id)
      photo.destroy
    end
  end
end
