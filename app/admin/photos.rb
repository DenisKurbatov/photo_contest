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
    column :comments_count do |photo|
      photo.comments_count
    end
    column :author do |photo|
      link_to photo.author_name, admin_user_path(photo.user_id)
    end
    state_column :status

    actions dropdown: true, defaults: false do |photo|
      if (photo.removed? || photo.approved?)
        if photo.removed?
          item I18n.t(:cancel_remove), cancel_remove_admin_photo_path(photo)
        else
          item I18n.t(:remove), remove_admin_photo_path(photo)
        end
      elsif photo.banned?
        item I18n.t(:approve), approve_admin_photo_path(photo)
        item I18n.t(:remove), remove_admin_photo_path(photo)
      else
        item I18n.t(:approve), approve_admin_photo_path(photo)
        item I18n.t(:ban), ban_admin_photo_path(photo)
        item I18n.t(:remove), remove_admin_photo_path(photo)
      end
    end
  end

  show do
    attributes_table do
      row :photo do |photo|
        image_tag photo.image.thumb.url
      end
      row :likes_count
      row :comments_count do |photo|
        photo.comments_count
      end
      row :author do |photo|
        link_to photo.author_name, admin_user_path(photo.user_id)
      end
      row :name
      row :created_at
      state_row :status
    end


    panel I18n.t('active_admin.photo.show.comments') do 
      table_for photo.comments do
        column :author_name
        column :body
        column :created_at
      end
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
    # resource.approve! if resource.versions.last.reify.approved?
    # resource.ban! if resource.versions.last.reify.banned?
    # resource.moder! if resource.versions.last.reify.moder?
    resource.update(status: resource.versions.last.reify.status)

    redirect_to admin_photos_path

  end
end
