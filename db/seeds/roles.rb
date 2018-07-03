# Creates required global roles
%w{
  Autorizado
  Administrador
}.each do |role|
  Rol.find_or_create_by name: role
end
