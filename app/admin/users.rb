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
    column :name
    column :photos do |p|
      Photo.where(user_id: p.id).count
    end
    actions default: false do |p|
      item "view", admin_user_path(p)
    end
  end

  show do
    attributes_table do
      row :provider
      row :name
      row :created_at
      row :updated_at
      
    end
    
  end
end
