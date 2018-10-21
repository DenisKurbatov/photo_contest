ActiveAdmin.register Photo do

  menu priority: 1
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  scope :all
  scope :banned
  scope :approved
  scope :moder


  index do
    selectable_column
    column :id
    column I18n.t('active_admin.photos.name'), :name
    column I18n.t('active_admin.photos.photo'), :photo do |p|
      image_tag p.image.thumb.url
    end
    column I18n.t('active_admin.photos.likes_count'), :likes_count
    column I18n.t('active_admin.photos.author'), :author do |p|
      User.find(p.user_id).name
    end
    column I18n.t('active_admin.photos.aasm_state'), :aasm_state
    actions dropdown: true do |p|
      item I18n.t(:approve), approve_admin_photo_path(p)
      item I18n.t(:ban), ban_admin_photo_path(p)
      item :remove, remove_admin_photo_path(p)
      item :cancel_remove, cancel_remove_admin_photo_path(p)
      
    end

  end

  member_action :approve do
    resource.approve!
    redirect_to admin_photos_path
  end
  member_action :ban do
    resource.ban!
    redirect_to admin_photos_path
  end
  member_action :remove do
    resource.remove!
    RemovePhotoWorker.perform_in(2.minutes, params[:id])
    redirect_to admin_photos_path
  end
  member_action :cancel_remove do
    resource.cancel_remove!
    redirect_to admin_photos_path
  end
end
