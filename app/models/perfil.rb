# encoding: utf-8
class Perfil < ActiveRecord::Base
  normalize_attributes :observaciones, :numero

  acts_as_taggable_on :etiquetas, :reconocedores

  # Permite utilizar roles de rolify sobre este modelo
  resourcify :roles, role_cname: 'Rol'

  scope :modales, ->{ where(modal: 'true') }

  before_validation :asociar_serie, :asociar_fase, :asociar_grupo

  validate :fecha_no_es_del_futuro
  validates_uniqueness_of :numero, scope: :serie_id, message: :no_es_unico_en_la_serie,
                          allow_nil: true, allow_blank: true
  validates_presence_of :fecha
  validates_numericality_of :cobertura_vegetal,
                            greater_than_or_equal_to: 0, less_than: 101,
                            allow_nil: true

  has_many :horizontes, -> { order('profundidad_inferior ASC') },
    dependent: :destroy, inverse_of: :perfil
  has_many :adjuntos,     dependent: :destroy, inverse_of: :perfil
  has_one :capacidad,     dependent: :destroy, inverse_of: :perfil
  has_one :ubicacion,     dependent: :destroy, inverse_of: :perfil
  has_one :paisaje,       dependent: :destroy, inverse_of: :perfil
  has_one :humedad,       dependent: :destroy, inverse_of: :perfil
  has_one :erosion,       dependent: :destroy, inverse_of: :perfil
  has_one :pedregosidad,  dependent: :destroy, inverse_of: :perfil

  has_many :analiticos,
    -> { includes(:horizonte).order('profundidad_muestra ASC, horizonte_id ASC') },
    through: :horizontes

  belongs_to :usuario
  belongs_to :fase
  belongs_to :grupo
  belongs_to :serie, counter_cache: :cantidad_de_perfiles

  has_lookups :escurrimiento, :pendiente, :permeabilidad, :relieve,
              :anegamiento, :posicion, :drenaje, :sal, :uso_de_la_tierra

  has_and_belongs_to_many :proyectos

  accepts_nested_attributes_for :capacidad, :paisaje, :ubicacion, :pedregosidad,
                                :humedad, :erosion,
                                limit: 1, allow_destroy: true
  accepts_nested_attributes_for :grupo, :fase, :serie, limit: 1, reject_if: :all_blank
  accepts_nested_attributes_for :horizontes, :analiticos, allow_destroy: true

  delegate :nombre,   to: :serie, allow_nil: true
  delegate :simbolo,  to: :serie, allow_nil: true
  delegate :provincia,  to: :serie, allow_nil: true
  delegate :coordenadas, :geolocalizado?, to: :ubicacion, allow_nil: true

  # Scope con los que tienen definidas las coordenadas
  def self.geolocalizados
    joins(:ubicacion).where('ubicaciones.coordenadas is not ?', nil)
  end

  # TODO agregar any: true para permitir combinar?
  ransacker :etiquetas, formatter: proc { |v|
      Perfil.tagged_with(Array.wrap(v.strip), on: :etiquetas).pluck(:id)
    } do |parent|
    parent.table[:id]
  end

  # TODO agregar any: true para permitir combinar?
  ransacker :reconocedores, formatter: proc { |v|
      Perfil.tagged_with(Array.wrap(v.strip), on: :reconocedores).pluck(:id)
    } do |parent|
    parent.table[:id]
  end

  def self.ransackable_attributes(auth_object = nil)
    super(auth_object) - ['created_at', 'updated_at']
  end

  def self.index
    joins(:ubicacion)
      .select('perfiles.fecha, perfiles.nombre,
        ubicacion.descripcion as ubicacion,
        perfiles.numero, perfiles.modal')
  end

  private

    # Validación para comprobar que no se guarda un perfil que aún no ha ocurrido.
    def fecha_no_es_del_futuro
      if fecha? and fecha > Date.today
        errors.add :fecha, :es_del_futuro
      end
    end

    # Se crea una serie sólo si no existe ya
    def asociar_serie
      # Si la serie ya existe no actualiza el símbolo. En otras palabras, desde
      # el perfil sólo se puede crear una serie, nunca modificarla
      if nombre
        _simbolo = simbolo
        # TODO debería pasar el usuario?
        self.serie = Serie.find_or_create_by(nombre: nombre, provincia_id: provincia.try(:id))

        # Cargo el símbolo sólo si no tiene. No se puede modificar el símbolo de
        # una serie existente desde un perfil.
        unless self.serie.simbolo.present? or _simbolo.nil?
          self.serie.update_attribute(:simbolo, _simbolo)
        end

        # Si este perfil es modal, queda como único modal de la serie
        if modal
          self.serie.perfiles.each do |p|
            p.update_attribute(:modal, false) unless p == self
          end
        end
      end
    end

    # Se crea una fase sólo si no existe ya
    def asociar_fase
      if fase.try(:nombre?)
        self.fase = Fase.find_or_create_by(nombre: fase.nombre)
      end
    end

    # Se crea un grupo sólo si no existe ya
    def asociar_grupo
      if grupo.try(:descripcion?)
        self.grupo = Grupo.find_or_create_by(descripcion: grupo.descripcion)
      end
    end
end
