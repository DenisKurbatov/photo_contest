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
    column :name
    column :photo do |p|
      image_tag p.image.thumb.url
    end
    column :likes_count
    column :author do |p|
      User.find(p.user_id).name
    end
    column :aasm_state
    actions dropdown: true do |p|
      item I18n.t(:approve), approve_admin_photo_path(p)
      item "ban", ban_admin_photo_path(p)
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
end
