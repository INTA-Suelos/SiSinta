# encoding: utf-8
class Usuario < ApplicationRecord
  rolify role_cname: 'Rol'
  # TODO Extraer preferencias a un modelo aparte
  # TODO Incluir idioma
  store :config, accessors: [:srid, :checks_csv_perfiles]

  # TODO cambiar relacion a 'creador'
  has_many :perfiles
  has_many :proyectos
  has_many :series
  has_many :busquedas
  has_many :adjuntos
  has_and_belongs_to_many :equipos
  belongs_to :ficha

  before_create :asignar_valores_por_defecto

  # Módulos a incluir de devise
  # TODO :confirmable cuando enviemos mails
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable

  validates :idioma, presence: true, inclusion: { in: I18n.available_locales.map(&:to_s) }
  validates :nombre, presence: true
  validates :ficha, presence: { on: :update }
  validates :srid, presence: { on: :update }

  # FIXME Workaround para cierto problema con rolify y las inflecciones
  alias_method :role_ids, :rol_ids
  alias_method :role_ids=, :rol_ids=

  # TODO Deshardcodear el nombre del rol +miembro+
  scope :miembros, ->(recurso) do
    joins(:roles).where('roles.resource_type' => recurso.class.to_s,
                        'roles.resource_id' => recurso.id,
                        'roles.name' => 'miembro')
  end
  scope :admins, ->{ with_role('Administrador') }

  def usa_ficha?(tipo)
    ficha.identificador == tipo
  end

  def admin?
    has_role? 'Administrador'
  end

  def autorizado?
    has_role? 'Autorizado'
  end

  # TODO Ver la manera de hacerlo a través de la asociación
  def roles_globales
    roles.where(resource_id: nil)
  end

  # Nombre del rol global (debería haber sólo uno)
  def rol_global
    roles_globales.first.try(:name)
  end

  # Asigno un rol global (Administrador, Autorizado), revocando los anteriores
  def rol_global=(nuevo_rol)
    roles_globales.each { |rol| self.revoke rol.name }
    self.grant nuevo_rol
  end

  protected

    def asignar_valores_por_defecto
      self.srid  ||= '4326'     # SRID para mostrar las coordenadas
    end
end
