ActiveAdmin.register User do
  permit_params :email, :username, :role_id, :status

  index do
    selectable_column
    id_column
    column :username
    column :email
    column :role_id do |user|
      user.role_id
    end
    column :status
    column :created_at
    actions
  end

  filter :username
  filter :email
  filter :role_id, as: :select, collection: Role.pluck(:name, :id) 
  filter :status
  filter :created_at

  form do |f|
    f.inputs do
      f.input :username
      f.input :email
      f.input :role_id, as: :select, collection: Role.pluck(:name, :id) 
      f.input :status
    end
    f.actions
  end
end
