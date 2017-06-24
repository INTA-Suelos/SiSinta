# Monkey patch para que ActiveAdmin use el default_url_options de
# ApplicationController en vez del de Rails.application. Más información
# en: https://github.com/activeadmin/activeadmin/issues/2074
require 'active_admin/helpers/routes/url_helpers'

ActiveAdmin::Helpers::Routes.class_eval do
  def self.default_url_options
    opciones_iniciales = Rails.application.config.action_mailer.default_url_options || {}

    opciones_iniciales.merge({ locale: ::I18n.locale })
  end
end
