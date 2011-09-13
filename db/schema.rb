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

ActiveRecord::Schema.define(:version => 20110913091043) do

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
  end

  create_table "observaciones", :force => true do |t|
    t.date     "fecha"
    t.string   "numero"
    t.boolean  "modal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
