# encoding: utf-8
class Perfil < ActiveRecord::Base
  attr_accessible :fecha, :numero, :drenaje_id, :profundidad_napa,
                  :cobertura_vegetal, :posicion_id, :pendiente_id,
                  :escurrimiento_id, :anegamiento_id, :grupo_id, :sal_id,
                  :uso_de_la_tierra_id, :material_original, :esquema,
                  :fase_id, :modal, :observaciones, :publico, :relieve_id,
                  :ubicacion_attributes, :paisaje_attributes, :fase_attributes,
                  :permeabilidad_id, :vegetacion_o_cultivos, :grupo_attributes,
                  :capacidad_attributes, :humedad_attributes,
                  :pedregosidad_attributes, :erosion_attributes, :etiquetas,
                  :reconocedores, :grupo, :serie_attributes, :anular,
                  :horizontes_attributes, :analiticos_attributes

  normalize_attributes :observaciones

  attr_taggable :etiquetas
  attr_taggable :reconocedores

  # Permite utilizar roles sobre este modelo
  resourcify role_cname: 'Rol'

  scope :modales, where(modal: 'true')
  scope :index,   joins(:ubicacion)
                  .select('perfiles.fecha, perfiles.nombre,
                           ubicacion.descripcion as ubicacion,
                           perfiles.numero, perfiles.modal')

  before_validation :asociar_serie, :asociar_fase, :asociar_grupo

  validate :fecha_no_es_del_futuro, :numero_es_unico_dentro_de_una_serie
  validates_presence_of :fecha
  validates_numericality_of :cobertura_vegetal,
                            greater_than_or_equal_to: 0, less_than: 101,
                            allow_nil: true

  has_many :horizontes,   dependent: :destroy, inverse_of: :perfil, order: 'profundidad_inferior ASC'
  has_many :adjuntos,     dependent: :destroy, inverse_of: :perfil
  has_one :capacidad,     dependent: :destroy, inverse_of: :perfil
  has_one :ubicacion,     dependent: :destroy, inverse_of: :perfil
  has_one :paisaje,       dependent: :destroy, inverse_of: :perfil
  has_one :humedad,       dependent: :destroy, inverse_of: :perfil
  has_one :erosion,       dependent: :destroy, inverse_of: :perfil
  has_one :pedregosidad,  dependent: :destroy, inverse_of: :perfil

  has_lookups :escurrimiento, :pendiente, :permeabilidad, :relieve,
              :anegamiento, :posicion, :drenaje, :sal, :uso_de_la_tierra

  has_many :analiticos, through: :horizontes, include: :horizonte,
    order: 'profundidad_muestra ASC, horizonte_id ASC'

  belongs_to :usuario,  inverse_of: :perfiles
  belongs_to :fase,     inverse_of: :perfiles
  belongs_to :grupo,    inverse_of: :perfiles
  belongs_to :serie,    inverse_of: :perfiles, counter_cache: :cantidad_de_perfiles

  has_and_belongs_to_many :proyectos

  accepts_nested_attributes_for :capacidad, :paisaje, :ubicacion, :pedregosidad,
                                :humedad, :erosion,
                                limit: 1, allow_destroy: true
  accepts_nested_attributes_for :grupo, :fase, :serie, limit: 1, reject_if: :all_blank
  accepts_nested_attributes_for :horizontes, :analiticos, allow_destroy: true

  delegate :nombre,   to: :serie, allow_nil: true
  delegate :simbolo,  to: :serie, allow_nil: true
  delegate :coordenadas, to: :ubicacion, allow_nil: true

  # Scope con los que tienen definidas las coordenadas
  def self.geolocalizados
    joins(:ubicacion).where('ubicaciones.coordenadas is not ?', nil)
  end

  private

    # Validación para comprobar que no se guarda un perfil que aún no ha ocurrido.
    def fecha_no_es_del_futuro
      if fecha? and fecha > Date.today
        errors.add :fecha, :es_del_futuro
      end
    end

    # Comprueba que no hay otros perfiles en la serie con el mismo número.
    # Permite nil en número.
    def numero_es_unico_dentro_de_una_serie
      if self.serie
        otros_perfiles = self.serie.perfiles.reject do |p|
          p.id == self.id or p.numero.blank?
        end
        if otros_perfiles.collect(&:numero).include?(self.numero)
          errors.add :numero, :no_es_unico_en_la_serie 
        end
      end
    end

    # Se crea una serie sólo si no existe ya
    def asociar_serie
      if nombre
        _simbolo = simbolo
        self.serie = Serie.find_or_create_by_nombre(nombre)

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
        self.fase = Fase.find_or_create_by_nombre(fase.nombre)
      end
    end

    # Se crea un grupo sólo si no existe ya
    def asociar_grupo
      if grupo.try(:descripcion?)
        self.grupo = Grupo.find_or_create_by_descripcion(grupo.descripcion)
      end
    end
end
