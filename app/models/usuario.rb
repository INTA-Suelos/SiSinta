# encoding: utf-8
class Usuario < ActiveRecord::Base
  has_and_belongs_to_many :roles
  has_many :calicatas, inverse_of: :usuario
  after_create :asignar_rol_por_defecto

  serialize :config, Hash

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :nombre, :email, :password, :password_confirmation,
                  :remember_me, :config, :current_password, :rol_ids

  scope :por_rol, joins(:roles).order('roles.nombre ASC')
  scope :admins, joins(:roles).where('roles.nombre = ?', 'administrador')

  def to_s
    nombre
  end

  def usa_ficha?(tipo)
    config[:ficha] == tipo ? true : false
  end

  def es? rol
    if rol.instance_of? Rol
      roles.include? rol
    else
      roles.include? Rol.find_by_nombre(rol.to_s)
    end
  end

  def admin?
    roles.include? Rol.administrador
  end

  def autorizado?
    roles.include? Rol.autorizado
  end

  def invitado?
    roles.include? Rol.invitado
  end

  protected

    def asignar_rol_por_defecto
      roles << Rol.invitado if roles.empty?
    end

end
