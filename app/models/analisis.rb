class Analisis < ActiveRecord::Base
  belongs_to :horizonte, :inverse_of => :analisis
  has_one :calicata, :through => :horizonte

  validates_presence_of :horizonte
  validates_numericality_of :registro, :arcilla, :limo_2_20, :limo_2_50,
                            :arena_muy_fina, :arena_fina, :arena_media,
                            :arena_gruesa, :arena_muy_gruesa, :ph_pasta,
                            :ph_h2o, :ph_kcl, :resistencia_pasta, :conductividad,
                            :base_ca, :base_mg, :base_k, :base_na, :s, :t, :h,
                            :peso_especifico_aparente,
                            :allow_nil => true
  validates_numericality_of :materia_organica_c, :materia_organica_n, :ca_co3,
                            :humedad, :agua_ret, :agua_util, :saturacion_t,
                            :saturacion_s_h,
                            :greater_than_or_equal_to => 0, :less_than => 101,
                            :allow_nil => true

  def materia_organica_cn
    begin
      (materia_organica_c/materia_organica_n).round
    rescue
      0
    end
  end
end
