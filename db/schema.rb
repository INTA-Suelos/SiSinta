# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120806212754) do

  create_table "adjuntos", :force => true do |t|
    t.integer  "calicata_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "archivo_file_name"
    t.string   "archivo_content_type"
    t.integer  "archivo_file_size"
    t.datetime "archivo_updated_at"
    t.string   "notas"
  end

  create_table "analisis", :force => true do |t|
    t.integer  "registro"
    t.decimal  "humedad",             :precision => 4, :scale => 2
    t.decimal  "s"
    t.decimal  "t"
    t.decimal  "ph_pasta"
    t.decimal  "ph_h2o"
    t.decimal  "ph_kcl"
    t.decimal  "resistencia_pasta"
    t.decimal  "base_ca"
    t.decimal  "base_mg"
    t.decimal  "base_k"
    t.decimal  "base_na"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "horizonte_id"
    t.decimal  "arcilla",             :precision => 4, :scale => 2
    t.decimal  "materia_organica_c",  :precision => 4, :scale => 2
    t.decimal  "materia_organica_n",  :precision => 4, :scale => 2
    t.decimal  "limo_2_20",           :precision => 4, :scale => 2
    t.decimal  "limo_2_50",           :precision => 4, :scale => 2
    t.decimal  "arena_muy_fina",      :precision => 4, :scale => 2
    t.decimal  "arena_fina",          :precision => 4, :scale => 2
    t.decimal  "arena_media",         :precision => 4, :scale => 2
    t.decimal  "arena_gruesa",        :precision => 4, :scale => 2
    t.decimal  "arena_muy_gruesa",    :precision => 4, :scale => 2
    t.decimal  "ca_co3",              :precision => 4, :scale => 2
    t.decimal  "agua_15_atm",         :precision => 4, :scale => 2
    t.decimal  "agua_util",           :precision => 4, :scale => 2
    t.decimal  "conductividad"
    t.decimal  "h"
    t.decimal  "saturacion_t",        :precision => 4, :scale => 2
    t.decimal  "saturacion_s_h",      :precision => 4, :scale => 2
    t.decimal  "densidad_aparente"
    t.integer  "materia_organica_cn"
    t.string   "profundidad_muestra"
    t.decimal  "agua_3_atm",          :precision => 4, :scale => 2
  end

  create_table "calicatas", :force => true do |t|
    t.string   "numero"
    t.integer  "drenaje_id"
    t.float    "profundidad_napa"
    t.decimal  "cobertura_vegetal"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "material_original"
    t.string   "esquema"
    t.string   "simbolo"
    t.integer  "fase_id"
    t.boolean  "modal",                 :default => false
    t.date     "fecha",                                    :null => false
    t.string   "observaciones"
    t.boolean  "publico",               :default => false
    t.integer  "usuario_id"
    t.integer  "relieve_id"
    t.integer  "posicion_id"
    t.integer  "pendiente_id"
    t.integer  "escurrimiento_id"
    t.integer  "permeabilidad_id"
    t.integer  "anegamiento_id"
    t.string   "nombre"
    t.integer  "grupo_id"
    t.integer  "sal_id"
    t.integer  "uso_de_la_tierra_id"
    t.string   "vegetacion_o_cultivos"
  end

  create_table "capacidades", :force => true do |t|
    t.integer "calicata_id"
    t.integer "clase_id"
    t.text    "subclase_ids"
  end

  add_index "capacidades", ["calicata_id"], :name => "index_capacidades_on_calicatas", :unique => true

  create_table "colores", :force => true do |t|
    t.string "hvc", :null => false
    t.string "rgb", :null => false
  end

  add_index "colores", ["hvc"], :name => "index_colores_on_hvc", :unique => true
  add_index "colores", ["rgb"], :name => "index_colores_on_rgb", :unique => true

  create_table "consistencias", :force => true do |t|
    t.integer  "horizonte_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "en_seco_id"
    t.integer  "en_humedo_id"
    t.integer  "adhesividad_id"
    t.integer  "plasticidad_id"
  end

  create_table "erosiones", :force => true do |t|
    t.integer "subclase_id"
    t.integer "clase_id"
    t.integer "calicata_id"
  end

  add_index "erosiones", ["calicata_id"], :name => "index_erosiones_on_calicatas", :unique => true

  create_table "estructuras", :force => true do |t|
    t.integer  "horizonte_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tipo_id"
    t.integer  "clase_id"
    t.integer  "grado_id"
  end

  create_table "fases", :force => true do |t|
    t.string "codigo", :limit => 2
    t.string "nombre", :limit => 15
  end

  add_index "fases", ["nombre"], :name => "index_fases_on_nombre", :unique => true

  create_table "grupos", :force => true do |t|
    t.string "codigo"
    t.string "descripcion"
  end

  add_index "grupos", ["descripcion"], :name => "index_grupos_on_descripcion", :unique => true

  create_table "horizontes", :force => true do |t|
    t.integer  "profundidad_superior"
    t.float    "ph"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "calicata_id"
    t.string   "humedad"
    t.string   "raices"
    t.string   "formaciones_especiales"
    t.string   "moteados"
    t.string   "barnices"
    t.string   "concreciones"
    t.string   "co3"
    t.string   "tipo"
    t.integer  "color_seco_id"
    t.integer  "color_humedo_id"
    t.integer  "profundidad_inferior"
    t.integer  "textura_id"
  end

  create_table "humedades", :force => true do |t|
    t.integer "subclase_id"
    t.integer "clase_id"
    t.integer "calicata_id"
  end

  add_index "humedades", ["calicata_id"], :name => "index_humedades_on_calicatas", :unique => true

  create_table "limites", :force => true do |t|
    t.integer  "horizonte_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tipo_id"
    t.integer  "forma_id"
  end

  create_table "lookups", :force => true do |t|
    t.string "type"
    t.string "valor2"
    t.string "valor1"
    t.string "valor3"
  end

  create_table "paisajes", :force => true do |t|
    t.string   "tipo"
    t.string   "forma"
    t.string   "simbolo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "calicata_id"
  end

  add_index "paisajes", ["calicata_id"], :name => "index_paisajes_on_calicatas", :unique => true

  create_table "pedregosidades", :force => true do |t|
    t.integer "subclase_id"
    t.integer "clase_id"
    t.integer "calicata_id"
  end

  add_index "pedregosidades", ["calicata_id"], :name => "index_pedregosidades_on_calicatas", :unique => true

  create_table "roles", :force => true do |t|
    t.string "nombre"
  end

  create_table "roles_usuarios", :id => false, :force => true do |t|
    t.integer "usuario_id"
    t.integer "rol_id"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "ubicaciones", :force => true do |t|
    t.string   "descripcion"
    t.integer  "calicata_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "recorrido"
    t.string   "mosaico"
    t.integer  "aerofoto"
    t.spatial  "coordenadas", :limit => {:srid=>4326, :type=>"point"}
  end

  add_index "ubicaciones", ["calicata_id"], :name => "index_ubicaciones_on_nombre", :unique => true
  add_index "ubicaciones", ["coordenadas"], :name => "index_ubicaciones_on_coordenadas", :spatial => true

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.text     "config"
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true

end
