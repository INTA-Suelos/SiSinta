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

ActiveRecord::Schema.define(:version => 20110930130050) do

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
  end

  create_table "horizontes", :force => true do |t|
    t.integer  "profundidad"
    t.string   "color_seco"
    t.string   "color_humedo"
    t.string   "tipo"
    t.string   "clase"
    t.string   "grado"
    t.float    "ph"
    t.string   "textura"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "observacion_id"
    t.integer  "position"
    t.string   "humedad"
    t.string   "raices"
    t.string   "formaciones_especiales"
    t.string   "moteados"
    t.string   "barnices"
    t.string   "concreciones"
    t.string   "co3"
  end

  create_table "observaciones", :force => true do |t|
    t.date     "fecha"
    t.string   "numero"
    t.boolean  "modal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.string   "password_digest"
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
