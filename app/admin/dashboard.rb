ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc{ I18n.t('active_admin.dashboard') }

  content title: proc{ I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel I18n.t 'admin.dashboard.administradores' do
          ul do
            Usuario.admins.decorate.each do |usuario|
              li link_to(usuario.nombre_y_mail, admin_usuario_path(usuario))
            end
          end
        end
      end

      column do
        panel I18n.t 'admin.dashboard.traduccion' do
          para "La traducción del sitio está dividida en dos partes. Por un
          lado, la #{link_to 'traducción de contenido estático', tolk_path}, o
          sea el contenido que no se puede cambiar sin modificar el código. Por
          el otro la traducción de contenido dinámico, o sea el texto que
          pertenece a los modelos de datos cuyos valores pueden editarse desde
          el sitio.".html_safe

          para "Para el primer tipo de contenido, puede #{link_to 'usar la
          interfaz especial', tolk_path}. Para el segundo, a través de cada
          modelo de datos desde el menú superior.".html_safe
        end
      end
    end
  end
end
