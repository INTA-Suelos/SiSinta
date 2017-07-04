#!/usr/bin/env Rscript

if (!"aqp" %in% installed.packages()){install.packages("aqp")}

args <- commandArgs(TRUE)

datos <- read.csv(args[1])

#datos <- sisINTAtoAQP(datos,color_seco = T )


require(aqp)
sisinta <- datos
# Color
color <- as.character(sisinta$color_humedo_hvc)
#if(color_seco){color <- as.character(sisinta$color_seco_hvc)}
sisinta$HUE <- substr(x = color,start = 0, stop = regexpr(" ", color)-1)
slash <- regexpr("/", color)
sisinta$VALUE <- substr(x = color, start = slash-1, stop = slash-1)
sisinta$CHROMA <- substr(x = color,start = slash+1, stop = slash+1)
sisinta$soil_color <- munsell2rgb(sisinta$HUE, sisinta$VALUE, sisinta$CHROMA)
rm(slash)

sisinta$X <- sisinta$perfil_ubicacion_latitud
sisinta$Y <- sisinta$perfil_ubicacion_longitud

#Remove empty horizons
sisinta <- sisinta[!is.na(sisinta$profundidad_superior),]

# Horizon data
Horizon <- with(sisinta, data.frame(as.character(perfil_numero), X, perfil_serie_simbolo, clase, profundidad_superior, profundidad_inferior,  analitico_registro, limite_tipo, limite_forma,
                                    estructura_tipo, estructura_clase, estructura_grado,
                                    analitico_arcilla, analitico_limo_2_20, analitico_limo_2_50,  analitico_arena_muy_fina, analitico_arena_fina, analitico_arena_media,
                                    analitico_arena_gruesa, analitico_arena_muy_gruesa, textura, analitico_humedad,
                                    analitico_densidad_aparente, analitico_agua_3_atm, analitico_agua_15_atm, analitico_agua_util,
                                    analitico_ph_pasta, analitico_ph_h2o, analitico_ph_kcl, analitico_conductividad, analitico_resistencia_pasta,
                                    analitico_carbono_organico_c, analitico_carbono_organico_n, analitico_carbono_organico_cn,
                                    analitico_ca_co3, co3, concreciones,
                                    analitico_h, analitico_s, analitico_t, analitico_saturacion_t, analitico_saturacion_s_h, analitico_base_ca, analitico_base_mg, analitico_base_k, analitico_base_na,
                                    barnices,  color_humedo_hvc, color_seco_hvc, consistencia_en_seco, consistencia_en_humedo, consistencia_adhesividad,
                                    consistencia_plasticidad, formaciones_especiales, humedad, moteados, soil_color))
names(Horizon) <- c("id", "X", "simbolo", "name", "top", "bottom", "analitico_registro", "limite_tipo", "limite_forma", "estructura_tipo", "estructura_clase", "estructura_grado",
                    "arcilla", "limo_20", "limo_50", "arena_muy_fina", "arena_fina", "arena_media", "arena_gruesa", "arena_muy_gruesa", "textura_campo", "humedad_satur",
                    "PEA", "agua_3_atm", "agua_15_atm", "Wd", "pH_pasta", "pH_H2O", "pH_KCl",   "CEes", "resistencia_pasta", "CO", "N", "CN", "CaCO3", "Reaccion_HCl",
                    "concreciones", "CIC_H", "CIC_S",  "CIC_T", "PorcSat_T", "PorcSat_H", "bases_Ca",  "bases_Mg", "bases_K", "bases_Na", "barnices",
                    "color_humedo", "color_seco", "consistencia_en_seco", "consistencia_en_humedo", "adhesividad", "plasticidad", "formaciones_especiales", "humedad", "moteados", "soil_color")
#Site Data


Sites <- with(sisinta, data.frame(as.character(perfil_numero), perfil_modal, perfil_fecha, X, Y, perfil_ubicacion_descripcion,
                                  perfil_ubicacion_mosaico, perfil_ubicacion_aerofoto, perfil_ubicacion_recorrido,
                                  perfil_serie_nombre, perfil_serie_simbolo, perfil_grupo_codigo, perfil_grupo_descripcion, perfil_fase_codigo, perfil_fase_nombre,
                                  perfil_capacidad_clase, perfil_paisaje_tipo, perfil_paisaje_forma, perfil_paisaje_simbolo,
                                  perfil_uso_de_la_tierra, perfil_vegetacion_o_cultivos, perfil_cobertura_vegetal, perfil_material_original,
                                  perfil_relieve, perfil_posicion, perfil_pendiente,
                                  perfil_escurrimiento, perfil_permeabilidad, perfil_anegamiento, perfil_drenaje,
                                  perfil_profundidad_napa,
                                  perfil_erosion_clase, perfil_erosion_subclase, perfil_pedregosidad_clase, perfil_pedregosidad_subclase,
                                  perfil_sales, perfil_observaciones))
names(Sites) <- c("id", "modal", "fecha", "X", "Y", "ubicacion_descripcion", "mosaico",
                  "aerofoto", "recorrido","serie", "simbolo",
                  "grupo", "grupo_descripcion", "fase_codigo", "fase_nombre", "capacidad_clase", "paisaje_tipo",
                  "paisaje_forma", "paisaje_simbolo", "uso_de_la_tierra", "vegetacion_o_cultivos", "cobertura_vegetal",
                  "material_originario", "relieve", "posicion", "pendiente",
                  "escurrimiento", "permeabilidad", "anegamiento", "drenaje",
                  "profundidad_napa", "erosion_grado", "erosion_tipo",
                  "pedregosidad_clase", "pedregosidad_grado", "sales", "observaciones")
suelos <- Horizon
suelos$soil_color <- as.character(suelos$soil_color)

depths(suelos) <- id ~ top + bottom


png(filename=as.character(args[2]))
if(length(suelos)>0){plot(suelos)}
dev.off()

