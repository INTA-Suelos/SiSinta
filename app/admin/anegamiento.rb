ActiveAdmin.register Anegamiento do
  menu parent: 'Perfiles'

  # Vista general
  index do
    selectable_column
    id_column
    column :valor
    translation_status
    actions
  end

  config.filters = false

  # Vista individual
  show do
    attributes_table do
      translated_row :valor, inline: false
    end

    active_admin_comments
  end

  # Vista de edición
  form do |f|
    f.inputs I18n.t 'active_admin.globalize.translations' do
      f.translated_inputs do |t|
        t.input :valor
      end
    end

    f.actions
  end

  permit_params translations_attributes: [
    :id, :locale, :title, :description, :_destroy
  ]
end
