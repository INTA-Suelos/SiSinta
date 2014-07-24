class Equipo < ActiveRecord::Base
  belongs_to :usuario
  has_and_belongs_to_many :miembros, class_name: 'Usuario'

  accepts_nested_attributes_for :miembros, allow_destroy: true

  # Permite utilizar roles sobre este modelo
  resourcify :roles, role_cname: 'Rol'

  def nuevo_miembro
    Usuario.new
  end

  # TODO validar que haya un usuario con esos valores
  def nuevo_miembro=(params = {})
    # A menos que ya haya un miembro con alguno de estos parámetros
    params.reject! {|key, value| value.blank?}
    unless miembros.where("nombre = ? or email = ? or id = ?",
                          params[:nombre], params[:email], params[:id] || 0).any?
      # Si viene un id debe ser por el autocompletar con ajax
      nuevo = if params[:id]
        Usuario.find(params[:id])
      # Si no, el usuario sin javascript puso un nombre y/o email.
      # Priorizamos el email
      elsif params[:email]
        Usuario.find_by_email(params[:email])
      else
        Usuario.find_by_nombre(params[:nombre]) unless params[:nombre].blank?
      end
      self.miembros << nuevo unless nuevo.blank?
    end
  end
end
