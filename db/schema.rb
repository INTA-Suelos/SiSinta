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

ActiveRecord::Schema.define(:version => 20111105002439) do

  create_table "analisis", :force => true do |t|
    t.column "registro", :integer
    t.column "humedad", :decimal
    t.column "s", :decimal
    t.column "t", :decimal
    t.column "ph_pasta", :decimal
    t.column "ph_h2o", :decimal
    t.column "ph_kcl", :decimal
    t.column "resistencia_pasta", :decimal
    t.column "base_ca", :decimal
    t.column "base_mg", :decimal
    t.column "base_k", :decimal
    t.column "base_na", :decimal
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "horizonte_id", :integer
    t.column "carbono", :decimal, :precision => 4, :scale => 2
    t.column "nitrogeno", :decimal, :precision => 4, :scale => 3
    t.column "arcilla", :decimal, :precision => 3, :scale => 1
  end

  create_table "calicatas", :force => true do |t|
    t.column "numero", :string
    t.column "drenaje", :integer
    t.column "escurrimiento", :integer
    t.column "permeabilidad", :integer
    t.column "profundidad_napa", :float
    t.column "anegamiento", :integer
    t.column "humedad_uniforme", :boolean
    t.column "cobertura_vegetal", :decimal
    t.column "uso_tierra", :string
    t.column "vegetacion", :string
    t.column "posicion", :string
    t.column "serie_id", :integer
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "ubicacion", :string
    t.column "pendiente", :string
    t.column "cobertura", :string
    t.column "material_original", :string
    t.column "taxonomia", :string
    t.column "esquema", :string
    t.column "mosaico", :string
    t.column "recorrido", :string
    t.column "aerofoto", :string
    t.column "fase", :string
    t.column "simbolo", :string
    t.column "gran_grupo", :string
    t.column "relieve", :string
    t.column "humedad", :string
    t.column "sales", :string
    t.column "pedregosidad", :string
    t.column "erosion", :string
    t.column "modal", :boolean, :default => false
    t.column "fecha", :date, :null => false
    t.column "observaciones", :string
    t.column "publico", :boolean, :default => true
  end

  create_table "clasificaciones", :force => true do |t|
    t.column "simbolo", :string
    t.column "limitaciones", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "calicata_id", :integer
  end

  create_table "colores", :force => true do |t|
    t.column "seco", :string
    t.column "humedo", :string
    t.column "horizonte_id", :integer
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "consistencias", :force => true do |t|
    t.column "seco", :string
    t.column "humedo", :string
    t.column "horizonte_id", :integer
    t.column "mojado_adhesividad", :string
    t.column "mojado_plasticidad", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "estructuras", :force => true do |t|
    t.column "tipo", :string
    t.column "clase", :string
    t.column "grado", :string
    t.column "horizonte_id", :integer
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "fases", :force => true do |t|
    t.column "codigo", :string, :limit => 2
    t.column "nombre", :string, :limit => 15
  end

  create_table "horizontes", :force => true do |t|
    t.column "profundidad", :integer
    t.column "ph", :float
    t.column "textura", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "calicata_id", :integer
    t.column "position", :integer
    t.column "humedad", :string
    t.column "raices", :string
    t.column "formaciones_especiales", :string
    t.column "moteados", :string
    t.column "barnices", :string
    t.column "concreciones", :string
    t.column "co3", :string
    t.column "tipo", :string
  end

  create_table "limites", :force => true do |t|
    t.column "tipo", :string
    t.column "forma", :string
    t.column "horizonte_id", :integer
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "paisajes", :force => true do |t|
    t.column "tipo", :string
    t.column "forma", :string
    t.column "simbolo", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "calicata_id", :integer
  end

  create_table "roles", :force => true do |t|
    t.column "nombre", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "roles_usuarios", :id => false, :force => true do |t|
    t.column "rol_id", :integer
    t.column "usuario_id", :integer
  end

  create_table "series", :force => true do |t|
    t.column "provincia", :string
    t.column "partido", :string
    t.column "simbolo", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "texturas", :force => true do |t|
    t.column "arcilla", :decimal, :precision => 3, :scale => 1
    t.column "limo_2_20", :decimal, :precision => 3, :scale => 1
    t.column "limo_2_50", :decimal, :precision => 3, :scale => 1
    t.column "arena_muy_fina", :decimal, :precision => 3, :scale => 1
    t.column "arena_fina", :decimal, :precision => 3, :scale => 1
    t.column "arena_media", :decimal, :precision => 3, :scale => 1
    t.column "arena_gruesa", :decimal, :precision => 3, :scale => 1
    t.column "arena_muy_gruesa", :decimal, :precision => 3, :scale => 1
    t.column "analisis_id", :integer
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "usuarios", :force => true do |t|
    t.column "nombre", :string
    t.column "password_digest", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "email", :string, :default => "", :null => false
    t.column "encrypted_password", :string, :limit => 128, :default => "", :null => false
    t.column "reset_password_token", :string
    t.column "reset_password_sent_at", :datetime
    t.column "remember_created_at", :datetime
    t.column "sign_in_count", :integer, :default => 0
    t.column "current_sign_in_at", :datetime
    t.column "last_sign_in_at", :datetime
    t.column "current_sign_in_ip", :string
    t.column "last_sign_in_ip", :string
    t.column "ficha", :string, :default => "completa"
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true

end
