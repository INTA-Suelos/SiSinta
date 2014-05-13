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

ActiveRecord::Schema.define(:version => 20140513073643) do

  create_table "adjuntos", :force => true do |t|
    t.integer  "perfil_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "archivo_file_name"
    t.string   "archivo_content_type"
    t.integer  "archivo_file_size"
    t.datetime "archivo_updated_at"
    t.string   "notas"
  end

  create_table "analiticos", :force => true do |t|
    t.integer  "registro"
    t.decimal  "humedad",             :precision => 5,  :scale => 2
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
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.integer  "horizonte_id"
    t.decimal  "arcilla",             :precision => 5,  :scale => 2
    t.decimal  "materia_organica_c",  :precision => 5,  :scale => 2
    t.decimal  "materia_organica_n",  :precision => 6,  :scale => 3
    t.decimal  "limo_2_20",           :precision => 5,  :scale => 2
    t.decimal  "limo_2_50",           :precision => 5,  :scale => 2
    t.decimal  "arena_muy_fina",      :precision => 5,  :scale => 2
    t.decimal  "arena_fina",          :precision => 5,  :scale => 2
    t.decimal  "arena_media",         :precision => 5,  :scale => 2
    t.decimal  "arena_gruesa",        :precision => 5,  :scale => 2
    t.decimal  "arena_muy_gruesa",    :precision => 5,  :scale => 2
    t.decimal  "ca_co3",              :precision => 5,  :scale => 2
    t.decimal  "agua_15_atm",         :precision => 5,  :scale => 2
    t.decimal  "agua_util",           :precision => 5,  :scale => 2
    t.decimal  "conductividad"
    t.decimal  "h"
    t.decimal  "saturacion_t",        :precision => 5,  :scale => 2
    t.decimal  "saturacion_s_h",      :precision => 5,  :scale => 2
    t.decimal  "densidad_aparente"
    t.string   "profundidad_muestra"
    t.decimal  "agua_3_atm",          :precision => 5,  :scale => 2
    t.decimal  "materia_organica_cn", :precision => 20, :scale => 1
  end

  create_table "busquedas", :force => true do |t|
    t.text     "consulta"
    t.integer  "usuario_id"
    t.string   "nombre"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "publico",    :default => false
  end

  create_table "capacidades", :force => true do |t|
    t.integer "perfil_id"
    t.integer "clase_id"
    t.text    "subclase_ids"
  end

  create_table "colores", :force => true do |t|
    t.string "hvc", :null => false
    t.string "rgb"
  end

  add_index "colores", ["hvc"], :name => "index_colores_on_hvc", :unique => true
  add_index "colores", ["rgb"], :name => "index_colores_on_rgb"

  create_table "consistencias", :force => true do |t|
    t.integer  "horizonte_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "en_seco_id"
    t.integer  "en_humedo_id"
    t.integer  "adhesividad_id"
    t.integer  "plasticidad_id"
  end

  create_table "equipos", :force => true do |t|
    t.string   "nombre",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "usuario_id"
  end

  add_index "equipos", ["nombre"], :name => "index_equipos_on_nombre", :unique => true

  create_table "equipos_usuarios", :id => false, :force => true do |t|
    t.integer "equipo_id"
    t.integer "usuario_id"
  end

  add_index "equipos_usuarios", ["usuario_id", "equipo_id"], :name => "index_equipos_usuarios_on_usuario_id_and_equipo_id"

  create_table "erosiones", :force => true do |t|
    t.integer "subclase_id"
    t.integer "clase_id"
    t.integer "perfil_id"
  end

  create_table "estructuras", :force => true do |t|
    t.integer  "horizonte_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "tipo_id"
    t.integer  "clase_id"
    t.integer  "grado_id"
  end

  create_table "fases", :force => true do |t|
    t.string "codigo", :limit => 2
    t.string "nombre"
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
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "perfil_id"
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
    t.integer "clase_id"
    t.integer "perfil_id"
    t.text    "subclase_ids"
  end

  create_table "limites", :force => true do |t|
    t.integer  "horizonte_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "tipo_id"
    t.integer  "forma_id"
  end

  create_table "paisajes", :force => true do |t|
    t.string   "tipo"
    t.string   "forma"
    t.string   "simbolo"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "perfil_id"
  end

  create_table "pedregosidades", :force => true do |t|
    t.integer "subclase_id"
    t.integer "clase_id"
    t.integer "perfil_id"
  end

  create_table "perfiles", :force => true do |t|
    t.string   "numero"
    t.integer  "drenaje_id"
    t.float    "profundidad_napa"
    t.decimal  "cobertura_vegetal"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "material_original"
    t.integer  "fase_id"
    t.boolean  "modal",                 :default => false
    t.date     "fecha",                                    :null => false
    t.boolean  "publico",               :default => false
    t.integer  "usuario_id"
    t.integer  "relieve_id"
    t.integer  "posicion_id"
    t.integer  "pendiente_id"
    t.integer  "escurrimiento_id"
    t.integer  "permeabilidad_id"
    t.integer  "anegamiento_id"
    t.integer  "grupo_id"
    t.integer  "sal_id"
    t.integer  "uso_de_la_tierra_id"
    t.string   "vegetacion_o_cultivos"
    t.integer  "serie_id"
    t.text     "observaciones"
  end

  create_table "perfiles_proyectos", :id => false, :force => true do |t|
    t.integer "proyecto_id"
    t.integer "perfil_id"
  end

  create_table "proyectos", :force => true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.text     "cita"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "usuario_id"
  end

  add_index "proyectos", ["nombre"], :name => "index_proyectos_on_nombre", :unique => true

  create_table "roles", :force => true do |t|
    t.string  "name"
    t.integer "resource_id"
    t.string  "resource_type"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "series", :force => true do |t|
    t.string   "nombre"
    t.string   "simbolo"
    t.text     "descripcion"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "cantidad_de_perfiles", :default => 0, :null => false
    t.integer  "usuario_id"
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

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], :name => "taggings_idx", :unique => true

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.integer "taggings_count", :default => 0
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

  create_table "ubicaciones", :force => true do |t|
    t.string   "descripcion"
    t.integer  "perfil_id"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.spatial  "coordenadas", :limit => {:srid=>4326, :type=>"point"}
    t.string   "recorrido"
    t.string   "mosaico"
    t.integer  "aerofoto"
  end

  add_index "ubicaciones", ["coordenadas"], :name => "index_ubicaciones_on_coordenadas", :spatial => true

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.text     "config"
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true

  create_table "usuarios_roles", :id => false, :force => true do |t|
    t.integer "usuario_id"
    t.integer "rol_id"
  end

  add_index "usuarios_roles", ["usuario_id", "rol_id"], :name => "index_roles_usuarios_on_usuario_id_and_rol_id"

end
