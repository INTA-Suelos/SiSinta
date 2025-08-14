# Roles base.
Rol.create(name: 'Autorizado') unless Rol.find_by(name: 'Autorizado').present?
Rol.create(name: 'Administrador') unless Rol.find_by(name: 'Administrador').present?

# Creates an admin if there are none
unless Usuario.admins.any?
  email = ENV['ADMIN_EMAIL']
  password = ENV['ADMIN_PASSWORD']
  name = ENV['ADMIN_NAME']

  Rails.logger.info 'Creating initial admin user'

  begin
    Usuario.create!(
      nombre: name,
      email: email,
      password: password
    ).grant 'Administrador'
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error e.message
    Rails.logger.error "Missing 'admin_email' param for admin creation" unless email
    Rails.logger.error "Missing 'admin_password' param for admin creation" unless password
    Rails.logger.error "Missing 'admin_name' param for admin creation" unless name

    raise
  end
end
