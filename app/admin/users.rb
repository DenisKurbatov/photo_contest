ActiveAdmin.register User do
  menu priority: 2
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

  actions :index, :show
  filter :name_or_uid, as: :string
  index do
    column :id
    column :uid
    column :name do |user|
      a user.name, href: user.url
    end
    column :photo do |user|
      image_tag user.image, size: '50x50'
    end
    column :photos_count do |user|
      link_to user.photos.count, admin_photos_path(q: { user_id_eq: user.id })
    end
    column :all_likes_count do |user|
      count = 0
      Photo.by_user(user.id).each { |x| count += x.likes_count }
      count
    end
  end

  show do
    attributes_table do
      row :photo do |user|
        image_tag user.image, size: '100x100'
      end
      row :name do |user|
        link_to user.name, user.url
      end
      row :email
      row :uid
      row :provider
      row :created_at
    end

    panel I18n.t('active_admin.user.show.photos'), as: :grid do
      user.photos.each do |photo|
        span link_to(image_tag(photo.image.thumb.url), admin_photo_path(photo.id))
      end
    end
  end
end
