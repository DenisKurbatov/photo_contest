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

  index do
    column :id
    column I18n.t('active_admin.users.name'), :name do |p|
      a p.name, href: p.url
    end
    column I18n.t('active_admin.photos.photo'), :photo do |p|
      image_tag p.image
    end
    column I18n.t('active_admin.users.photos'), :photos do |p|
      Photo.where(user_id: p.id).count
    end
    column :count do |p|
      count = 0
      Photo.by_user(p.id).each { |x| count+=x.likes_count }
      count
    end
    
    
    actions dropdown: true
  end
end
