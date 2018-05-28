# Creates an admin if there are none
unless Usuario.admins.any?
  email = ENV['admin_email']
  password = ENV['admin_password']
  name = ENV['admin_name']

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
