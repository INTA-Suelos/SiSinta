# -*- encoding : utf-8 -*-
class Calicata < ActiveRecord::Base

  validate :la_fecha_no_puede_ser_futura
  validates_presence_of :fecha
  validates_numericality_of :cobertura_vegetal, :only_integer => true, :allow_nil => true,
                            :greater_than => 0, :less_than => 101

  has_many :horizontes,   :dependent => :destroy, :inverse_of => :calicata
  has_many :fotos,        :dependent => :destroy, :inverse_of => :calicata
  has_one :capacidad,     :dependent => :destroy, :inverse_of => :calicata
  has_one :ubicacion,     :dependent => :destroy, :inverse_of => :calicata

  has_one :paisaje,       :inverse_of => :calicata

  #
  # Tablas de lookup. Las asociaciones 1 a 1 pueden ser:
  #   belongs_to => calicata tiene lookup_id
  #   has_one => lookup tiene calicata_id
  # Como los valores de estas tablas son un conjunto definido, se comparten
  # entre todas las calicatas, aunque suene raro un belongs_to acá.
  #
  belongs_to :escurrimiento,  :inverse_of => :calicatas
  belongs_to :pendiente,      :inverse_of => :calicatas
  belongs_to :permeabilidad,  :inverse_of => :calicatas
  belongs_to :relieve,        :inverse_of => :calicatas
  belongs_to :anegamiento,    :inverse_of => :calicatas
  belongs_to :posicion,       :inverse_of => :calicatas
  belongs_to :drenaje,        :inverse_of => :calicatas

  has_many :analisis,       :through => :horizontes
  has_many :estructuras,    :through => :horizontes
  has_many :colores,        :through => :horizontes
  has_many :consistencias,  :through => :horizontes
  has_many :limites,        :through => :horizontes

  belongs_to :usuario, :inverse_of => :calicatas
  belongs_to :fase, :inverse_of => :calicatas, :autosave => true
  belongs_to :serie, :inverse_of => :calicatas, :autosave => true, :validate => false

  accepts_nested_attributes_for :capacidad, :paisaje, :horizontes, :serie, :fase,
                                :ubicacion, :reject_if => :all_blank

  @@asociaciones = %w{capacidad fase serie paisaje escurrimiento pendiente permeabilidad relieve anegamiento
                      posicion ubicacion drenaje}

  #
  # Construye los objetos asociados a la calicata, para usar con el +FormHelper+, si es que no
  # existen ya.
  #
  # * *Args*    :
  #   - +calicata+ -> la instancia de calicata sobre la que construir las asociaciones
  # * *Returns* :
  #   - la calicata con las asociaciones preparadas
  #
  def preparar
    @@asociaciones.each do |asociacion|
      self.send("build_#{asociacion}") if self.send(asociacion).nil?
    end
    return self
  end

  # Este método se llama cuando se intenta guardar la serie asociada a la calicata.
  #
  # * *Args*    :
  #   - ++ ->
  # * *Returns* :
  #   -
  # * *Raises* :
  #   - ++ ->
  #
  def autosave_associated_records_for_serie
    if not serie.nil?
      if serie_existente = Serie.find_or_create_by_nombre(:nombre => serie.nombre,
                                                          :simbolo => serie.simbolo) then
        self.serie = serie_existente
      else
        self.serie.save!
      end
    end
  end

# == Validaciones

  #
  # Validación para comprobar que no se guarda una calicata que no ha ocurrido.
  #
  def la_fecha_no_puede_ser_futura
    if !fecha.blank? and fecha > Date.today
      errors.add(:fecha, I18n.t("error por fecha futura"))
    end
  end

end
