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

  controller do
    def scoped_collection
      if params[:user_id].present?
        end_of_association_chain.where(user_id: params[:user_id])
      else
        end_of_association_chain.all
      end
    end
  end

  index do
    selectable_column
    column :id
    column :name
    column :photo do |p|
      image_tag p.image.thumb.url
    end
    column :likes_count
    column :author do |p|
      a User.find(p.user_id).name, href: User.find(p.user_id).url
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
