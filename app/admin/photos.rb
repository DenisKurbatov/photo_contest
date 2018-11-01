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
  config.per_page = 8
  actions :index, :show

  scope :all
  scope :banned
  scope :approved
  scope :moder

  filter :name, as: :string
  filter :likes_count, as: :numeric

  index do
    column :id
    column :name
    column :photo do |photo|
      link_to(image_tag(photo.image.thumb.url), admin_photo_path(photo.id))
    end
    column :likes_count
    column :author do |photo|
      link_to photo.author_name, admin_user_path(photo.user_id)
    end
    state_column :aasm_state

    actions dropdown: true, defaults: false do |p|
      if p.aasm_state == 'moder'
        item I18n.t(:approve), approve_admin_photo_path(p)
        item I18n.t(:ban), ban_admin_photo_path(p)
        item I18n.t(:remove), remove_admin_photo_path(p)
      end
      item I18n.t(:remove), remove_admin_photo_path(p) if p.aasm_state == 'approved'
      if p.aasm_state == 'banned'
        item I18n.t(:approve), approve_admin_photo_path(p)
        item I18n.t(:remove), remove_admin_photo_path(p)
      end
      item I18n.t(:cancel_remove), cancel_remove_admin_photo_path(p) if p.aasm_state == 'removed'
    end
  end

  show do
    attributes_table do
      row :photo do |photo|
        image_tag photo.image.thumb.url
      end
      row :likes_count
      row :author do |photo|
        link_to photo.author_name, admin_user_path(photo.user_id)
      end
      row :name
      row :created_at
      state_row :aasm_state
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
    redirect_to admin_photos_path
  end
  member_action :cancel_remove do
    resource.cancel_remove!
    redirect_to admin_photos_path
  end
end
