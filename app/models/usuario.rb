# encoding: utf-8
class Usuario < ActiveRecord::Base
  rolify :role_cname => 'Rol'
  store :config, accessors: [:ficha, :srid]

  has_many :perfiles, inverse_of: :usuario
  after_initialize :asignar_valores_por_defecto

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :nombre, :email, :password, :password_confirmation,
                  :remember_me, :config, :current_password, :ficha, :srid

  def to_s
    nombre
  end

  def usa_ficha?(tipo)
    ficha == tipo
  end

  def admin?
    has_role? :admin
  end

  protected

    def asignar_valores_por_defecto
      self.ficha ||= 'completa' # Ficha con la que cargar un perfil
      self.srid  ||= '4326'     # SRID para mostrar las coordenadas
    end

end
