class AnaliticoSerializer < ActiveModel::Serializer
  attributes  :registro, :humedad, :s, :t, :ph_pasta, :ph_h2o, :ph_kcl,
              :resistencia_pasta, :base_ca, :base_mg, :base_k, :base_na,
              :arcilla, :carbono_organico_c, :carbono_organico_n, :limo_2_20,
              :limo_2_50, :arena_muy_fina, :arena_fina, :arena_media,
              :arena_gruesa, :arena_muy_gruesa, :ca_co3, :agua_15_atm,
              :agua_util, :conductividad, :h, :saturacion_t, :saturacion_s_h,
              :densidad_aparente, :profundidad_muestra, :agua_3_atm,
              :carbono_organico_cn, :base_al, :p_ppm
end
