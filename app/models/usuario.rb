# encoding: utf-8
class Usuario < ActiveRecord::Base
  store :config, accessors: [:ficha, :srid]

  has_and_belongs_to_many :roles
  has_many :perfiles, inverse_of: :usuario
  after_create :asignar_rol_inicial
  after_initialize :asignar_valores_por_defecto

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :nombre, :email, :password, :password_confirmation,
                  :remember_me, :config, :current_password, :rol_ids,
                  :ficha, :srid

  scope :por_rol, joins(:roles).order('roles.nombre ASC')
  scope :admins, joins(:roles).where('roles.nombre = ?', 'administrador')

  def to_s
    nombre
  end

  def usa_ficha?(tipo)
    ficha == tipo
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

    # No asigno un rol por defecto para los nuevos usuarios porque quiero un
    # usuario anónimo sin roles
    def asignar_rol_inicial
      roles << Rol.invitado if roles.empty?
    end

    def asignar_valores_por_defecto
      self.ficha ||= 'completa'
      self.srid  ||= '4326'
    end

end
