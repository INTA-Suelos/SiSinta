# encoding: utf-8
class Usuario < ActiveRecord::Base
  has_and_belongs_to_many :roles
  has_many :calicatas, inverse_of: :usuario
  after_create :asignar_rol_por_defecto

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :nombre, :email, :password, :password_confirmation,
                  :remember_me, :ficha, :current_password

  scope :por_rol, joins(:roles).order('roles.nombre ASC')
  scope :admins, joins(:roles).where('roles.nombre = ?', 'administrador')

  def to_s
    nombre
  end

  def usa_ficha_simple?
    self.ficha == 'simple' ? true : false
  end

  def es? rol
    if rol.instance_of? Rol
      self.roles.include? rol
    else
      self.roles.include? Rol.find_by_nombre(rol.to_s)
    end
  end

  def admin?
    self.roles.include? Rol.administrador
  end

  def autorizado?
    self.roles.include? Rol.autorizado
  end

  def invitado?
    self.roles.include? Rol.invitado
  end

  protected

    def asignar_rol_por_defecto
      self.roles << Rol.invitado
    end

end
