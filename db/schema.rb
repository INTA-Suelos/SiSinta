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

ActiveRecord::Schema.define(:version => 20120507102245) do

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
    t.decimal  "humedad"
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
    t.decimal  "arcilla",             :precision => 3, :scale => 1
    t.decimal  "materia_organica_c",  :precision => 3, :scale => 2
    t.decimal  "materia_organica_n",  :precision => 3, :scale => 2
    t.decimal  "limo_2_20",           :precision => 3, :scale => 1
    t.decimal  "limo_2_50",           :precision => 3, :scale => 1
    t.decimal  "arena_muy_fina",      :precision => 3, :scale => 1
    t.decimal  "arena_fina",          :precision => 3, :scale => 1
    t.decimal  "arena_media",         :precision => 3, :scale => 1
    t.decimal  "arena_gruesa",        :precision => 3, :scale => 1
    t.decimal  "arena_muy_gruesa",    :precision => 3, :scale => 1
    t.decimal  "ca_co3",              :precision => 3, :scale => 2
    t.decimal  "agua_ret",            :precision => 3, :scale => 2
    t.decimal  "agua_util",           :precision => 3, :scale => 2
    t.decimal  "conductividad"
    t.decimal  "h"
    t.decimal  "saturacion_t",        :precision => 3, :scale => 2
    t.decimal  "saturacion_s_h",      :precision => 3, :scale => 2
    t.decimal  "densidad_aparente"
    t.integer  "materia_organica_cn"
    t.string   "profundidad_muestra"
  end

  create_table "calicatas", :force => true do |t|
    t.string   "numero"
    t.integer  "drenaje_id"
    t.float    "profundidad_napa"
    t.boolean  "humedad_uniforme"
    t.decimal  "cobertura_vegetal"
    t.string   "vegetacion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cobertura"
    t.string   "material_original"
    t.string   "taxonomia"
    t.string   "esquema"
    t.string   "pedregosidad"
    t.string   "simbolo"
    t.string   "humedad"
    t.string   "erosion"
    t.integer  "fase_id"
    t.boolean  "modal",             :default => false
    t.date     "fecha",                                :null => false
    t.string   "observaciones"
    t.boolean  "publico",           :default => false
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
    t.integer  "uso_tierra_id"
  end

  create_table "capacidad_subclases_capacidades", :id => false, :force => true do |t|
    t.integer "capacidad_id"
    t.integer "capacidad_subclase_id"
  end

  create_table "capacidades", :force => true do |t|
    t.integer "calicata_id"
    t.integer "capacidad_clase_id"
  end

  create_table "colores", :force => true do |t|
    t.string "hvc", :null => false
    t.string "rgb", :null => false
  end

  add_index "colores", ["hvc"], :name => "index_colores_on_hvc", :unique => true
  add_index "colores", ["rgb"], :name => "index_colores_on_rgb", :unique => true

  create_table "consistencias", :force => true do |t|
    t.string   "seco"
    t.string   "humedo"
    t.integer  "horizonte_id"
    t.string   "mojado_adhesividad"
    t.string   "mojado_plasticidad"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estructuras", :force => true do |t|
    t.string   "tipo"
    t.string   "clase"
    t.string   "grado"
    t.integer  "horizonte_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fases", :force => true do |t|
    t.string "codigo", :limit => 2
    t.string "nombre", :limit => 15
  end

  create_table "grupos", :force => true do |t|
    t.string "codigo"
    t.string "descripcion"
  end

  create_table "horizontes", :force => true do |t|
    t.integer  "profundidad_superior"
    t.float    "ph"
    t.string   "textura"
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
  end

  create_table "limites", :force => true do |t|
    t.integer  "horizonte_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "limite_tipo_id"
    t.integer  "limite_forma_id"
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

  create_table "roles", :force => true do |t|
    t.string "nombre"
  end

  create_table "roles_usuarios", :id => false, :force => true do |t|
    t.integer "usuario_id"
    t.integer "rol_id"
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

  add_index "ubicaciones", ["coordenadas"], :name => "index_ubicaciones_on_coordenadas", :spatial => true

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                                 :default => "",         :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",         :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "ficha",                                 :default => "completa"
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true

end
