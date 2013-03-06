# encoding: utf-8
class Usuario < ActiveRecord::Base
  rolify role_cname: 'Rol'
  store :config, accessors: [:ficha, :srid, :checks_csv_perfiles]

  has_many :perfiles, inverse_of: :usuario
  has_and_belongs_to_many :equipos

  before_create :asignar_valores_por_defecto

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :nombre, :email, :password, :password_confirmation,
                  :remember_me, :config, :current_password, :ficha, :srid

  validates_presence_of :ficha, :srid, on: :update

  # FIXME Workarround para cierto problema con rolify y las inflecciones
  alias_method :role_ids, :rol_ids
  alias_method :role_ids=, :rol_ids=

  # TODO Deshardcodear el nombre del rol +miembro+
  scope :miembros, ->(recurso) do
    joins(:roles).where("roles.resource_type" => recurso.class.to_s,
                        "roles.resource_id" => recurso.id,
                        "roles.name" => "miembro")
  end

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
