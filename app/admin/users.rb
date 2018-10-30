ActiveAdmin.register User do
  menu priorety: 2
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

  filter :name_or_uid, as: :string

  index do
    column :id
    column :uid
    column :name do |p|
      a p.name, href: p.url
    end
    column :photo do |p|
      image_tag p.image, size: "50x50"
    end
    column :photos_count do |p|
      link_to Photo.where(user_id: p.id).count, admin_photos_path(user_id: p.id)
    end
    column :all_likes_count do |p|
      count = 0
      Photo.by_user(p.id).each { |x| count += x.likes_count }
      count
    end
  end
end
