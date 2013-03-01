# encoding: utf-8
class Analitico < ActiveRecord::Base
  attr_accessible :registro, :horizonte_attributes, :profundidad_muestra,
                  :materia_organica_c, :materia_organica_n, :humedad, :s, :t,
                  :ph_pasta, :ph_h2o, :ph_kcl, :resistencia_pasta, :base_ca,
                  :base_mg, :base_k, :base_na, :arcilla, :limo_2_20, :limo_2_50,
                  :arena_muy_fina, :arena_fina, :arena_gruesa, :arena_media,
                  :arena_muy_gruesa, :ca_co3, :agua_15_atm, :agua_util,
                  :conductividad, :h, :saturacion_t, :saturacion_s_h,
                  :densidad_aparente, :materia_organica_cn, :agua_3_atm

  belongs_to :horizonte
  has_one :perfil, through: :horizonte

  validates_presence_of :horizonte
  validates_numericality_of :registro,:ph_pasta, :densidad_aparente,
                            :ph_h2o, :ph_kcl, :resistencia_pasta, :conductividad,
                            :base_ca, :base_mg, :base_k, :base_na, :s, :t, :h,
                            allow_nil: true
  validates_numericality_of :materia_organica_c, :materia_organica_n, :ca_co3,
                            :arcilla, :limo_2_20, :limo_2_50, :arena_muy_fina,
                            :arena_fina, :arena_media, :arena_gruesa,
                            :arena_muy_gruesa, :humedad, :agua_3_atm,
                            :agua_15_atm, :agua_util, :saturacion_t,
                            :saturacion_s_h,
                            greater_than_or_equal_to: 0, less_than_or_equal_to: 100,
                            allow_nil: true
  validates_numericality_of :materia_organica_cn,
                            greater_than_or_equal_to: 0, less_than: 10,
                            allow_nil: true

  accepts_nested_attributes_for :horizonte

  delegate :publico, to: :perfil
end
