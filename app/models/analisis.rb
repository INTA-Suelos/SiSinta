# encoding: utf-8
class Analisis < ActiveRecord::Base
  belongs_to :horizonte, inverse_of: :analisis
  has_one :perfil, through: :horizonte

  validates_presence_of :horizonte
  validates_numericality_of :registro,:ph_pasta,
                            :ph_h2o, :ph_kcl, :resistencia_pasta, :conductividad,
                            :base_ca, :base_mg, :base_k, :base_na, :s, :t, :h,
                            :densidad_aparente, :materia_organica_cn,
                            allow_nil: true
  validates_numericality_of :materia_organica_c, :materia_organica_n, :ca_co3,
                            :arcilla, :limo_2_20, :limo_2_50, :arena_muy_fina,
                            :arena_fina, :arena_media, :arena_gruesa,
                            :arena_muy_gruesa, :humedad, :agua_3_atm,
                            :agua_15_atm, :agua_util, :saturacion_t,
                            :saturacion_s_h,
                            greater_than_or_equal_to: 0, less_than: 101,
                            allow_nil: true

  accepts_nested_attributes_for :horizonte

  def materia_organica_cn_before_type_cast
    begin
      read_attribute(:materia_organica_cn) || (materia_organica_c/materia_organica_n).round
    rescue
      nil
    end
  end

  def profundidad_muestra_before_type_cast
    read_attribute(:profundidad_muestra) || self.horizonte.try(:rango_profundidad)
  end

  def agua_util_before_type_cast
    begin
      read_attribute(:agua_util) || (agua_3_atm - agua_15_atm)
    rescue
      nil
    end
  end

  def profundidad_muestra
    profundidad_muestra_before_type_cast
  end

  def materia_organica_cn
    materia_organica_cn_before_type_cast
  end

  def agua_util
    agua_util_before_type_cast
  end

  def publico
    perfil.publico
  end

end
