# encoding: utf-8
class Analitico < ActiveRecord::Base
  belongs_to :horizonte, inverse_of: :analitico
  has_one :perfil, through: :horizonte

  validates :horizonte, presence: true
  validates_numericality_of :registro, :ph_pasta, :densidad_aparente, :ph_h2o,
                            :ph_kcl, :resistencia_pasta, :conductividad,
                            :base_ca, :base_mg, :base_k, :base_na, :base_al,
                            :s, :t, :h, :carbono_organico_cn,
                            allow_nil: true
  # Porcentajes
  validates_numericality_of :carbono_organico_c, :carbono_organico_n, :ca_co3,
                            :arcilla, :limo_2_20, :limo_2_50, :arena_muy_fina,
                            :arena_fina, :arena_media, :arena_gruesa,
                            :arena_muy_gruesa, :arena_total, :gravas, :humedad,
                            :agua_3_atm, :agua_15_atm, :agua_util, :saturacion_t,
                            :saturacion_s_h, :p_ppm,
                            greater_than_or_equal_to: 0, less_than_or_equal_to: 100,
                            allow_nil: true

  accepts_nested_attributes_for :horizonte

  delegate :publico, :usuario, :usuario_id, to: :horizonte

  def self.ransackable_attributes(auth_object = nil)
    super(auth_object) - ['created_at', 'updated_at', 'perfil_id', 'id']
  end

  def porcentaje_mo
    carbono_organico_c.present? ? (carbono_organico_c * 1.724).round(2) : nil
  end

  def psi
    base_na.present? && t.present? ? (base_na / (t * 100.0)).round(1) : nil
  end
end
