ActiveAdmin.register Usuario do
  menu priority: 2

  permit_params :nombre, :email, :password, :password_confirmation, :rol_global

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  show do
    attributes_table do
      row :nombre
      row :email
      row :idioma
      row :rol_global
      row :created_at
      row :sign_in_count
      row :current_sign_in_at
    end

    active_admin_comments
  end

  form do |f|
    f.inputs 'Detalles' do
      f.input :nombre
      f.input :email
      f.input :password unless usuario.persisted?
      f.input :password_confirmation unless usuario.persisted?
      f.input :rol_global, as: :select,
        collection: Rol.globales.collect(&:name).sort, include_blank: true
    end
    f.actions
  end
end
