# Carga el usuario administrador inicial, sólo si no hay usuarios
unless Usuario.any?
  Rails.logger.info <<MSG

  Creando usuario administrador con:
    email:    admin@cambiame.com
    password: cambiame

MSG

  Usuario.create(
    nombre:   'Administra Administrador',
    email:    'admin@cambiame.com',
    password: 'cambiame'
  ).grant 'Administrador'
end
