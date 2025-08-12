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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170724131053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "postgis_topology"
  enable_extension "fuzzystrmatch"
  enable_extension "postgis_tiger_geocoder"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "addr", primary_key: "gid", force: :cascade do |t|
    t.integer "tlid",      limit: 8
    t.string  "fromhn",    limit: 12
    t.string  "tohn",      limit: 12
    t.string  "side",      limit: 1
    t.string  "zip",       limit: 5
    t.string  "plus4",     limit: 4
    t.string  "fromtyp",   limit: 1
    t.string  "totyp",     limit: 1
    t.integer "fromarmid"
    t.integer "toarmid"
    t.string  "arid",      limit: 22
    t.string  "mtfcc",     limit: 5
    t.string  "statefp",   limit: 2
  end

  add_index "addr", ["tlid", "statefp"], name: "idx_tiger_addr_tlid_statefp", using: :btree
  add_index "addr", ["zip"], name: "idx_tiger_addr_zip", using: :btree

  create_table "addrfeat", primary_key: "gid", force: :cascade do |t|
    t.integer  "tlid",       limit: 8
    t.string   "statefp",    limit: 2,                                   null: false
    t.string   "aridl",      limit: 22
    t.string   "aridr",      limit: 22
    t.string   "linearid",   limit: 22
    t.string   "fullname",   limit: 100
    t.string   "lfromhn",    limit: 12
    t.string   "ltohn",      limit: 12
    t.string   "rfromhn",    limit: 12
    t.string   "rtohn",      limit: 12
    t.string   "zipl",       limit: 5
    t.string   "zipr",       limit: 5
    t.string   "edge_mtfcc", limit: 5
    t.string   "parityl",    limit: 1
    t.string   "parityr",    limit: 1
    t.string   "plus4l",     limit: 4
    t.string   "plus4r",     limit: 4
    t.string   "lfromtyp",   limit: 1
    t.string   "ltotyp",     limit: 1
    t.string   "rfromtyp",   limit: 1
    t.string   "rtotyp",     limit: 1
    t.string   "offsetl",    limit: 1
    t.string   "offsetr",    limit: 1
    t.geometry "the_geom",   limit: {:srid=>4269, :type=>"line_string"}
  end

  add_index "addrfeat", ["the_geom"], name: "idx_addrfeat_geom_gist", using: :gist
  add_index "addrfeat", ["tlid"], name: "idx_addrfeat_tlid", using: :btree
  add_index "addrfeat", ["zipl"], name: "idx_addrfeat_zipl", using: :btree
  add_index "addrfeat", ["zipr"], name: "idx_addrfeat_zipr", using: :btree

  create_table "adhesividad_translations", force: :cascade do |t|
    t.integer  "adhesividad_id", null: false
    t.string   "locale",         null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "valor"
  end

  add_index "adhesividad_translations", ["adhesividad_id"], name: "index_adhesividad_translations_on_adhesividad_id", using: :btree
  add_index "adhesividad_translations", ["locale"], name: "index_adhesividad_translations_on_locale", using: :btree

  create_table "adhesividades", force: :cascade do |t|
  end

  create_table "adjuntos", force: :cascade do |t|
    t.integer  "perfil_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "archivo_file_name"
    t.string   "archivo_content_type"
    t.integer  "archivo_file_size"
    t.datetime "archivo_updated_at"
    t.string   "notas"
    t.boolean  "publico",              default: false
    t.integer  "usuario_id"
  end

  add_index "adjuntos", ["perfil_id"], name: "index_adjuntos_on_perfil_id", using: :btree
  add_index "adjuntos", ["usuario_id"], name: "index_adjuntos_on_usuario_id", using: :btree

  create_table "analiticos", force: :cascade do |t|
    t.integer  "registro"
    t.decimal  "humedad",             precision: 5,  scale: 2
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
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "horizonte_id"
    t.decimal  "arcilla",             precision: 5,  scale: 2
    t.decimal  "carbono_organico_c",  precision: 5,  scale: 2
    t.decimal  "carbono_organico_n",  precision: 6,  scale: 3
    t.decimal  "limo_2_20",           precision: 5,  scale: 2
    t.decimal  "limo_2_50",           precision: 5,  scale: 2
    t.decimal  "arena_muy_fina",      precision: 5,  scale: 2
    t.decimal  "arena_fina",          precision: 5,  scale: 2
    t.decimal  "arena_media",         precision: 5,  scale: 2
    t.decimal  "arena_gruesa",        precision: 5,  scale: 2
    t.decimal  "arena_muy_gruesa",    precision: 5,  scale: 2
    t.decimal  "ca_co3",              precision: 5,  scale: 2
    t.decimal  "agua_15_atm",         precision: 5,  scale: 2
    t.decimal  "agua_util",           precision: 5,  scale: 2
    t.decimal  "conductividad"
    t.decimal  "h"
    t.decimal  "saturacion_t",        precision: 5,  scale: 2
    t.decimal  "saturacion_s_h",      precision: 5,  scale: 2
    t.decimal  "densidad_aparente"
    t.string   "profundidad_muestra"
    t.decimal  "agua_3_atm",          precision: 5,  scale: 2
    t.decimal  "carbono_organico_cn", precision: 20, scale: 1
    t.decimal  "base_al"
    t.decimal  "p_ppm",               precision: 4,  scale: 1
    t.decimal  "arena_total",         precision: 5,  scale: 2
    t.decimal  "gravas",              precision: 5,  scale: 2
  end

  add_index "analiticos", ["horizonte_id"], name: "index_analiticos_on_horizonte_id", unique: true, using: :btree

  create_table "anegamiento_translations", force: :cascade do |t|
    t.integer  "anegamiento_id", null: false
    t.string   "locale",         null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "valor"
  end

  add_index "anegamiento_translations", ["anegamiento_id"], name: "index_anegamiento_translations_on_anegamiento_id", using: :btree
  add_index "anegamiento_translations", ["locale"], name: "index_anegamiento_translations_on_locale", using: :btree

  create_table "anegamientos", force: :cascade do |t|
  end

  create_table "bg", primary_key: "bg_id", force: :cascade do |t|
    t.integer  "gid",                                                    default: "nextval('bg_gid_seq'::regclass)", null: false
    t.string   "statefp",  limit: 2
    t.string   "countyfp", limit: 3
    t.string   "tractce",  limit: 6
    t.string   "blkgrpce", limit: 1
    t.string   "namelsad", limit: 13
    t.string   "mtfcc",    limit: 5
    t.string   "funcstat", limit: 1
    t.float    "aland"
    t.float    "awater"
    t.string   "intptlat", limit: 11
    t.string   "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>4269, :type=>"multi_polygon"}
  end

  create_table "busquedas", force: :cascade do |t|
    t.text     "consulta"
    t.integer  "usuario_id"
    t.string   "nombre"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "publico",    default: false
  end

  add_index "busquedas", ["usuario_id"], name: "index_busquedas_on_usuario_id", using: :btree

  create_table "capacidades", force: :cascade do |t|
    t.integer "perfil_id"
    t.integer "clase_id"
  end

  add_index "capacidades", ["perfil_id"], name: "index_capacidades_on_perfil_id", unique: true, using: :btree

  create_table "capacidades_subclases_de_capacidad", id: false, force: :cascade do |t|
    t.integer "capacidad_id",             null: false
    t.integer "subclase_de_capacidad_id", null: false
  end

  add_index "capacidades_subclases_de_capacidad", ["subclase_de_capacidad_id", "capacidad_id"], name: "subclases_capacidades", unique: true, using: :btree

  create_table "clase_de_capacidad_translations", force: :cascade do |t|
    t.integer  "clase_de_capacidad_id", null: false
    t.string   "locale",                null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "codigo"
    t.string   "descripcion"
    t.string   "categoria"
  end

  add_index "clase_de_capacidad_translations", ["clase_de_capacidad_id"], name: "index_clase_de_capacidad_translations_on_clase_de_capacidad_id", using: :btree
  add_index "clase_de_capacidad_translations", ["locale"], name: "index_clase_de_capacidad_translations_on_locale", using: :btree

  create_table "clase_de_erosion_translations", force: :cascade do |t|
    t.integer  "clase_de_erosion_id", null: false
    t.string   "locale",              null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "valor"
  end

  add_index "clase_de_erosion_translations", ["clase_de_erosion_id"], name: "index_clase_de_erosion_translations_on_clase_de_erosion_id", using: :btree
  add_index "clase_de_erosion_translations", ["locale"], name: "index_clase_de_erosion_translations_on_locale", using: :btree

  create_table "clases_de_capacidad", force: :cascade do |t|
  end

  create_table "clases_de_erosion", force: :cascade do |t|
  end

  create_table "clases_de_estructura", force: :cascade do |t|
    t.string "valor", null: false
  end

  create_table "clases_de_humedad", force: :cascade do |t|
    t.string "valor", null: false
  end

  create_table "clases_de_pedregosidad", force: :cascade do |t|
    t.string "valor", null: false
  end

  create_table "colores", force: :cascade do |t|
    t.string "hvc", null: false
    t.string "rgb"
  end

  add_index "colores", ["hvc"], name: "index_colores_on_hvc", unique: true, using: :btree
  add_index "colores", ["rgb"], name: "index_colores_on_rgb", using: :btree

  create_table "consistencias", force: :cascade do |t|
    t.integer  "horizonte_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "en_seco_id"
    t.integer  "en_humedo_id"
    t.integer  "adhesividad_id"
    t.integer  "plasticidad_id"
  end

  add_index "consistencias", ["horizonte_id"], name: "index_consistencias_on_horizonte_id", unique: true, using: :btree

  create_table "consistencias_en_humedo", force: :cascade do |t|
    t.string "valor", null: false
  end

  create_table "consistencias_en_seco", force: :cascade do |t|
    t.string "valor", null: false
  end

  create_table "county", primary_key: "cntyidfp", force: :cascade do |t|
    t.integer  "gid",                                                    default: "nextval('county_gid_seq'::regclass)", null: false
    t.string   "statefp",  limit: 2
    t.string   "countyfp", limit: 3
    t.string   "countyns", limit: 8
    t.string   "name",     limit: 100
    t.string   "namelsad", limit: 100
    t.string   "lsad",     limit: 2
    t.string   "classfp",  limit: 2
    t.string   "mtfcc",    limit: 5
    t.string   "csafp",    limit: 3
    t.string   "cbsafp",   limit: 5
    t.string   "metdivfp", limit: 5
    t.string   "funcstat", limit: 1
    t.integer  "aland",    limit: 8
    t.float    "awater"
    t.string   "intptlat", limit: 11
    t.string   "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>4269, :type=>"multi_polygon"}
  end

  add_index "county", ["countyfp"], name: "idx_tiger_county", using: :btree
  add_index "county", ["gid"], name: "uidx_county_gid", unique: true, using: :btree

  create_table "county_lookup", id: false, force: :cascade do |t|
    t.integer "st_code",            null: false
    t.string  "state",   limit: 2
    t.integer "co_code",            null: false
    t.string  "name",    limit: 90
  end

  add_index "county_lookup", ["state"], name: "county_lookup_state_idx", using: :btree

  create_table "countysub_lookup", id: false, force: :cascade do |t|
    t.integer "st_code",            null: false
    t.string  "state",   limit: 2
    t.integer "co_code",            null: false
    t.string  "county",  limit: 90
    t.integer "cs_code",            null: false
    t.string  "name",    limit: 90
  end

  add_index "countysub_lookup", ["state"], name: "countysub_lookup_state_idx", using: :btree

  create_table "cousub", primary_key: "cosbidfp", force: :cascade do |t|
    t.integer  "gid",                                                                   default: "nextval('cousub_gid_seq'::regclass)", null: false
    t.string   "statefp",  limit: 2
    t.string   "countyfp", limit: 3
    t.string   "cousubfp", limit: 5
    t.string   "cousubns", limit: 8
    t.string   "name",     limit: 100
    t.string   "namelsad", limit: 100
    t.string   "lsad",     limit: 2
    t.string   "classfp",  limit: 2
    t.string   "mtfcc",    limit: 5
    t.string   "cnectafp", limit: 3
    t.string   "nectafp",  limit: 5
    t.string   "nctadvfp", limit: 5
    t.string   "funcstat", limit: 1
    t.decimal  "aland",                                                  precision: 14
    t.decimal  "awater",                                                 precision: 14
    t.string   "intptlat", limit: 11
    t.string   "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>4269, :type=>"multi_polygon"}
  end

  add_index "cousub", ["gid"], name: "uidx_cousub_gid", unique: true, using: :btree
  add_index "cousub", ["the_geom"], name: "tige_cousub_the_geom_gist", using: :gist

  create_table "direction_lookup", primary_key: "name", force: :cascade do |t|
    t.string "abbrev", limit: 3
  end

  add_index "direction_lookup", ["abbrev"], name: "direction_lookup_abbrev_idx", using: :btree

  create_table "drenajes", force: :cascade do |t|
    t.string "valor", null: false
  end

  create_table "edges", primary_key: "gid", force: :cascade do |t|
    t.string   "statefp",    limit: 2
    t.string   "countyfp",   limit: 3
    t.integer  "tlid",       limit: 8
    t.decimal  "tfidl",                                                        precision: 10
    t.decimal  "tfidr",                                                        precision: 10
    t.string   "mtfcc",      limit: 5
    t.string   "fullname",   limit: 100
    t.string   "smid",       limit: 22
    t.string   "lfromadd",   limit: 12
    t.string   "ltoadd",     limit: 12
    t.string   "rfromadd",   limit: 12
    t.string   "rtoadd",     limit: 12
    t.string   "zipl",       limit: 5
    t.string   "zipr",       limit: 5
    t.string   "featcat",    limit: 1
    t.string   "hydroflg",   limit: 1
    t.string   "railflg",    limit: 1
    t.string   "roadflg",    limit: 1
    t.string   "olfflg",     limit: 1
    t.string   "passflg",    limit: 1
    t.string   "divroad",    limit: 1
    t.string   "exttyp",     limit: 1
    t.string   "ttyp",       limit: 1
    t.string   "deckedroad", limit: 1
    t.string   "artpath",    limit: 1
    t.string   "persist",    limit: 1
    t.string   "gcseflg",    limit: 1
    t.string   "offsetl",    limit: 1
    t.string   "offsetr",    limit: 1
    t.decimal  "tnidf",                                                        precision: 10
    t.decimal  "tnidt",                                                        precision: 10
    t.geometry "the_geom",   limit: {:srid=>4269, :type=>"multi_line_string"}
  end

  add_index "edges", ["countyfp"], name: "idx_tiger_edges_countyfp", using: :btree
  add_index "edges", ["the_geom"], name: "idx_tiger_edges_the_geom_gist", using: :gist
  add_index "edges", ["tlid"], name: "idx_edges_tlid", using: :btree

  create_table "equipos", force: :cascade do |t|
    t.string   "nombre",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "usuario_id"
  end

  add_index "equipos", ["nombre"], name: "index_equipos_on_nombre", unique: true, using: :btree
  add_index "equipos", ["usuario_id"], name: "index_equipos_on_usuario_id", using: :btree

  create_table "equipos_usuarios", id: false, force: :cascade do |t|
    t.integer "equipo_id"
    t.integer "usuario_id"
  end

  add_index "equipos_usuarios", ["usuario_id", "equipo_id"], name: "index_equipos_usuarios_on_usuario_id_and_equipo_id", using: :btree

  create_table "erosiones", force: :cascade do |t|
    t.integer "subclase_id"
    t.integer "clase_id"
    t.integer "perfil_id"
  end

  add_index "erosiones", ["perfil_id"], name: "index_erosiones_on_perfil_id", unique: true, using: :btree

  create_table "escurrimientos", force: :cascade do |t|
    t.string "valor", null: false
  end

  create_table "estructuras", force: :cascade do |t|
    t.integer  "horizonte_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "tipo_id"
    t.integer  "clase_id"
    t.integer  "grado_id"
  end

  add_index "estructuras", ["horizonte_id"], name: "index_estructuras_on_horizonte_id", unique: true, using: :btree

  create_table "faces", primary_key: "gid", force: :cascade do |t|
    t.decimal  "tfid",                                                     precision: 10
    t.string   "statefp00",  limit: 2
    t.string   "countyfp00", limit: 3
    t.string   "tractce00",  limit: 6
    t.string   "blkgrpce00", limit: 1
    t.string   "blockce00",  limit: 4
    t.string   "cousubfp00", limit: 5
    t.string   "submcdfp00", limit: 5
    t.string   "conctyfp00", limit: 5
    t.string   "placefp00",  limit: 5
    t.string   "aiannhfp00", limit: 5
    t.string   "aiannhce00", limit: 4
    t.string   "comptyp00",  limit: 1
    t.string   "trsubfp00",  limit: 5
    t.string   "trsubce00",  limit: 3
    t.string   "anrcfp00",   limit: 5
    t.string   "elsdlea00",  limit: 5
    t.string   "scsdlea00",  limit: 5
    t.string   "unsdlea00",  limit: 5
    t.string   "uace00",     limit: 5
    t.string   "cd108fp",    limit: 2
    t.string   "sldust00",   limit: 3
    t.string   "sldlst00",   limit: 3
    t.string   "vtdst00",    limit: 6
    t.string   "zcta5ce00",  limit: 5
    t.string   "tazce00",    limit: 6
    t.string   "ugace00",    limit: 5
    t.string   "puma5ce00",  limit: 5
    t.string   "statefp",    limit: 2
    t.string   "countyfp",   limit: 3
    t.string   "tractce",    limit: 6
    t.string   "blkgrpce",   limit: 1
    t.string   "blockce",    limit: 4
    t.string   "cousubfp",   limit: 5
    t.string   "submcdfp",   limit: 5
    t.string   "conctyfp",   limit: 5
    t.string   "placefp",    limit: 5
    t.string   "aiannhfp",   limit: 5
    t.string   "aiannhce",   limit: 4
    t.string   "comptyp",    limit: 1
    t.string   "trsubfp",    limit: 5
    t.string   "trsubce",    limit: 3
    t.string   "anrcfp",     limit: 5
    t.string   "ttractce",   limit: 6
    t.string   "tblkgpce",   limit: 1
    t.string   "elsdlea",    limit: 5
    t.string   "scsdlea",    limit: 5
    t.string   "unsdlea",    limit: 5
    t.string   "uace",       limit: 5
    t.string   "cd111fp",    limit: 2
    t.string   "sldust",     limit: 3
    t.string   "sldlst",     limit: 3
    t.string   "vtdst",      limit: 6
    t.string   "zcta5ce",    limit: 5
    t.string   "tazce",      limit: 6
    t.string   "ugace",      limit: 5
    t.string   "puma5ce",    limit: 5
    t.string   "csafp",      limit: 3
    t.string   "cbsafp",     limit: 5
    t.string   "metdivfp",   limit: 5
    t.string   "cnectafp",   limit: 3
    t.string   "nectafp",    limit: 5
    t.string   "nctadvfp",   limit: 5
    t.string   "lwflag",     limit: 1
    t.string   "offset",     limit: 1
    t.float    "atotal"
    t.string   "intptlat",   limit: 11
    t.string   "intptlon",   limit: 12
    t.geometry "the_geom",   limit: {:srid=>4269, :type=>"multi_polygon"}
  end

  add_index "faces", ["countyfp"], name: "idx_tiger_faces_countyfp", using: :btree
  add_index "faces", ["tfid"], name: "idx_tiger_faces_tfid", using: :btree
  add_index "faces", ["the_geom"], name: "tiger_faces_the_geom_gist", using: :gist

  create_table "fases", force: :cascade do |t|
    t.string "codigo", limit: 2
    t.string "nombre"
  end

  add_index "fases", ["nombre"], name: "index_fases_on_nombre", unique: true, using: :btree

  create_table "featnames", primary_key: "gid", force: :cascade do |t|
    t.integer "tlid",       limit: 8
    t.string  "fullname",   limit: 100
    t.string  "name",       limit: 100
    t.string  "predirabrv", limit: 15
    t.string  "pretypabrv", limit: 50
    t.string  "prequalabr", limit: 15
    t.string  "sufdirabrv", limit: 15
    t.string  "suftypabrv", limit: 50
    t.string  "sufqualabr", limit: 15
    t.string  "predir",     limit: 2
    t.string  "pretyp",     limit: 3
    t.string  "prequal",    limit: 2
    t.string  "sufdir",     limit: 2
    t.string  "suftyp",     limit: 3
    t.string  "sufqual",    limit: 2
    t.string  "linearid",   limit: 22
    t.string  "mtfcc",      limit: 5
    t.string  "paflag",     limit: 1
    t.string  "statefp",    limit: 2
  end

  add_index "featnames", ["tlid", "statefp"], name: "idx_tiger_featnames_tlid_statefp", using: :btree

  create_table "fichas", force: :cascade do |t|
    t.string   "nombre",                        null: false
    t.string   "identificador",                 null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "default",       default: false
  end

  add_index "fichas", ["identificador"], name: "index_fichas_on_identificador", unique: true, using: :btree

  create_table "formas_de_limite", force: :cascade do |t|
    t.string "valor", null: false
  end

  create_table "formatos_de_coordenadas", force: :cascade do |t|
    t.integer "srid",        null: false
    t.string  "descripcion", null: false
  end

  create_table "geocode_settings", primary_key: "name", force: :cascade do |t|
    t.text "setting"
    t.text "unit"
    t.text "category"
    t.text "short_desc"
  end

  create_table "geocode_settings_default", primary_key: "name", force: :cascade do |t|
    t.text "setting"
    t.text "unit"
    t.text "category"
    t.text "short_desc"
  end

  create_table "grados_de_estructura", force: :cascade do |t|
    t.string "valor", null: false
  end

  create_table "grupos", force: :cascade do |t|
    t.string "codigo"
    t.string "descripcion"
  end

  add_index "grupos", ["descripcion"], name: "index_grupos_on_descripcion", unique: true, using: :btree

  create_table "horizontes", force: :cascade do |t|
    t.integer  "profundidad_superior"
    t.float    "ph"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
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

  add_index "horizontes", ["perfil_id"], name: "index_horizontes_on_perfil_id", using: :btree

  create_table "humedades", force: :cascade do |t|
    t.integer "clase_id"
    t.integer "perfil_id"
  end

  add_index "humedades", ["perfil_id"], name: "index_humedades_on_perfil_id", unique: true, using: :btree

  create_table "humedades_subclases_de_humedad", id: false, force: :cascade do |t|
    t.integer "humedad_id",             null: false
    t.integer "subclase_de_humedad_id", null: false
  end

  add_index "humedades_subclases_de_humedad", ["subclase_de_humedad_id", "humedad_id"], name: "subclases_humedades", unique: true, using: :btree

  create_table "ign_provincias", primary_key: "gid", force: :cascade do |t|
    t.string    "objeto", limit: 50
    t.string    "fna",    limit: 150
    t.string    "gna",    limit: 50
    t.string    "nam",    limit: 100
    t.string    "sag",    limit: 50
    t.geography "geog",   limit: {:srid=>4326, :type=>"multi_polygon", :has_z=>true, :has_m=>true, :geographic=>true}
  end

  add_index "ign_provincias", ["geog"], name: "ign_provincias_geog_idx", using: :gist

  create_table "limites", force: :cascade do |t|
    t.integer  "horizonte_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "tipo_id"
    t.integer  "forma_id"
  end

  add_index "limites", ["horizonte_id"], name: "index_limites_on_horizonte_id", unique: true, using: :btree

  create_table "loader_lookuptables", primary_key: "lookup_name", force: :cascade do |t|
    t.integer "process_order",                   default: 1000,  null: false
    t.text    "table_name"
    t.boolean "single_mode",                     default: true,  null: false
    t.boolean "load",                            default: true,  null: false
    t.boolean "level_county",                    default: false, null: false
    t.boolean "level_state",                     default: false, null: false
    t.boolean "level_nation",                    default: false, null: false
    t.text    "post_load_process"
    t.boolean "single_geom_mode",                default: false
    t.string  "insert_mode",           limit: 1, default: "c",   null: false
    t.text    "pre_load_process"
    t.text    "columns_exclude",                                              array: true
    t.text    "website_root_override"
  end

  create_table "loader_platform", primary_key: "os", force: :cascade do |t|
    t.text "declare_sect"
    t.text "pgbin"
    t.text "wget"
    t.text "unzip_command"
    t.text "psql"
    t.text "path_sep"
    t.text "loader"
    t.text "environ_set_command"
    t.text "county_process_command"
  end

  create_table "loader_variables", primary_key: "tiger_year", force: :cascade do |t|
    t.text "website_root"
    t.text "staging_fold"
    t.text "data_schema"
    t.text "staging_schema"
  end

  create_table "pagc_gaz", force: :cascade do |t|
    t.integer "seq"
    t.text    "word"
    t.text    "stdword"
    t.integer "token"
    t.boolean "is_custom", default: true, null: false
  end

  create_table "pagc_lex", force: :cascade do |t|
    t.integer "seq"
    t.text    "word"
    t.text    "stdword"
    t.integer "token"
    t.boolean "is_custom", default: true, null: false
  end

  create_table "pagc_rules", force: :cascade do |t|
    t.text    "rule"
    t.boolean "is_custom", default: true
  end

  create_table "paisajes", force: :cascade do |t|
    t.string   "tipo"
    t.string   "forma"
    t.string   "simbolo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "perfil_id"
  end

  add_index "paisajes", ["perfil_id"], name: "index_paisajes_on_perfil_id", unique: true, using: :btree

  create_table "pedregosidades", force: :cascade do |t|
    t.integer "subclase_id"
    t.integer "clase_id"
    t.integer "perfil_id"
  end

  add_index "pedregosidades", ["perfil_id"], name: "index_pedregosidades_on_perfil_id", unique: true, using: :btree

  create_table "pendientes", force: :cascade do |t|
    t.string "valor", null: false
  end

  create_table "perfiles", force: :cascade do |t|
    t.string   "numero"
    t.integer  "drenaje_id"
    t.float    "profundidad_napa"
    t.decimal  "cobertura_vegetal"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "material_original"
    t.integer  "fase_id"
    t.boolean  "modal",                 default: false
    t.date     "fecha",                                 null: false
    t.boolean  "publico",               default: false
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

  add_index "perfiles", ["serie_id"], name: "index_perfiles_on_serie_id", using: :btree
  add_index "perfiles", ["usuario_id"], name: "index_perfiles_on_usuario_id", using: :btree

  create_table "perfiles_proyectos", id: false, force: :cascade do |t|
    t.integer "proyecto_id"
    t.integer "perfil_id"
  end

  add_index "perfiles_proyectos", ["proyecto_id", "perfil_id"], name: "index_perfiles_proyectos_on_proyecto_id_and_perfil_id", using: :btree

  create_table "permeabilidades", force: :cascade do |t|
    t.string "valor", null: false
  end

  create_table "place", primary_key: "plcidfp", force: :cascade do |t|
    t.integer  "gid",                                                    default: "nextval('place_gid_seq'::regclass)", null: false
    t.string   "statefp",  limit: 2
    t.string   "placefp",  limit: 5
    t.string   "placens",  limit: 8
    t.string   "name",     limit: 100
    t.string   "namelsad", limit: 100
    t.string   "lsad",     limit: 2
    t.string   "classfp",  limit: 2
    t.string   "cpi",      limit: 1
    t.string   "pcicbsa",  limit: 1
    t.string   "pcinecta", limit: 1
    t.string   "mtfcc",    limit: 5
    t.string   "funcstat", limit: 1
    t.integer  "aland",    limit: 8
    t.integer  "awater",   limit: 8
    t.string   "intptlat", limit: 11
    t.string   "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>4269, :type=>"multi_polygon"}
  end

  add_index "place", ["gid"], name: "uidx_tiger_place_gid", unique: true, using: :btree
  add_index "place", ["the_geom"], name: "tiger_place_the_geom_gist", using: :gist

  create_table "place_lookup", id: false, force: :cascade do |t|
    t.integer "st_code",            null: false
    t.string  "state",   limit: 2
    t.integer "pl_code",            null: false
    t.string  "name",    limit: 90
  end

  add_index "place_lookup", ["state"], name: "place_lookup_state_idx", using: :btree

  create_table "plasticidades", force: :cascade do |t|
    t.string "valor", null: false
  end

  create_table "posiciones", force: :cascade do |t|
    t.string "valor", null: false
  end

  create_table "provincias", force: :cascade do |t|
    t.string  "nombre",            null: false
    t.string  "pais_alpha_3"
    t.integer "data_oficial_id"
    t.string  "data_oficial_type"
  end

  add_index "provincias", ["data_oficial_type", "data_oficial_id"], name: "index_provincias_on_data_oficial_type_and_data_oficial_id", using: :btree

  create_table "proyectos", force: :cascade do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.text     "cita"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "usuario_id"
  end

  add_index "proyectos", ["nombre"], name: "index_proyectos_on_nombre", unique: true, using: :btree

  create_table "relieves", force: :cascade do |t|
    t.string "valor", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string  "name"
    t.integer "resource_id"
    t.string  "resource_type"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "sales", force: :cascade do |t|
    t.string "valor", null: false
  end

  create_table "secondary_unit_lookup", primary_key: "name", force: :cascade do |t|
    t.string "abbrev", limit: 5
  end

  add_index "secondary_unit_lookup", ["abbrev"], name: "secondary_unit_lookup_abbrev_idx", using: :btree

  create_table "series", force: :cascade do |t|
    t.string   "nombre"
    t.string   "simbolo"
    t.text     "descripcion"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "cantidad_de_perfiles", default: 0, null: false
    t.integer  "usuario_id"
    t.integer  "provincia_id"
  end

  add_index "series", ["provincia_id"], name: "index_series_on_provincia_id", using: :btree

  create_table "state", primary_key: "statefp", force: :cascade do |t|
    t.integer  "gid",                                                    default: "nextval('state_gid_seq'::regclass)", null: false
    t.string   "region",   limit: 2
    t.string   "division", limit: 2
    t.string   "statens",  limit: 8
    t.string   "stusps",   limit: 2,                                                                                    null: false
    t.string   "name",     limit: 100
    t.string   "lsad",     limit: 2
    t.string   "mtfcc",    limit: 5
    t.string   "funcstat", limit: 1
    t.integer  "aland",    limit: 8
    t.integer  "awater",   limit: 8
    t.string   "intptlat", limit: 11
    t.string   "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>4269, :type=>"multi_polygon"}
  end

  add_index "state", ["gid"], name: "uidx_tiger_state_gid", unique: true, using: :btree
  add_index "state", ["stusps"], name: "uidx_tiger_state_stusps", unique: true, using: :btree
  add_index "state", ["the_geom"], name: "idx_tiger_state_the_geom_gist", using: :gist

  create_table "state_lookup", primary_key: "st_code", force: :cascade do |t|
    t.string "name",    limit: 40
    t.string "abbrev",  limit: 3
    t.string "statefp", limit: 2
  end

  add_index "state_lookup", ["abbrev"], name: "state_lookup_abbrev_key", unique: true, using: :btree
  add_index "state_lookup", ["name"], name: "state_lookup_name_key", unique: true, using: :btree
  add_index "state_lookup", ["statefp"], name: "state_lookup_statefp_key", unique: true, using: :btree

  create_table "street_type_lookup", primary_key: "name", force: :cascade do |t|
    t.string  "abbrev", limit: 50
    t.boolean "is_hw",             default: false, null: false
  end

  add_index "street_type_lookup", ["abbrev"], name: "street_type_lookup_abbrev_idx", using: :btree

  create_table "subclases_de_capacidad", force: :cascade do |t|
    t.string "codigo",      null: false
    t.string "descripcion"
  end

  create_table "subclases_de_erosion", force: :cascade do |t|
    t.string "valor", null: false
  end

  create_table "subclases_de_humedad", force: :cascade do |t|
    t.string "valor", null: false
  end

  create_table "subclases_de_pedregosidad", force: :cascade do |t|
    t.string "valor", null: false
  end

  create_table "tabblock", primary_key: "tabblock_id", force: :cascade do |t|
    t.integer  "gid",                                                    default: "nextval('tabblock_gid_seq'::regclass)", null: false
    t.string   "statefp",  limit: 2
    t.string   "countyfp", limit: 3
    t.string   "tractce",  limit: 6
    t.string   "blockce",  limit: 4
    t.string   "name",     limit: 20
    t.string   "mtfcc",    limit: 5
    t.string   "ur",       limit: 1
    t.string   "uace",     limit: 5
    t.string   "funcstat", limit: 1
    t.float    "aland"
    t.float    "awater"
    t.string   "intptlat", limit: 11
    t.string   "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>4269, :type=>"multi_polygon"}
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "texturas", force: :cascade do |t|
    t.string "clase",   null: false
    t.string "textura"
    t.string "suelo"
  end

  create_table "tipos_de_estructura", force: :cascade do |t|
    t.string "valor", null: false
  end

  create_table "tipos_de_limite", force: :cascade do |t|
    t.string "valor", null: false
  end

  create_table "tolk_locales", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tolk_locales", ["name"], name: "index_tolk_locales_on_name", unique: true, using: :btree

  create_table "tolk_phrases", force: :cascade do |t|
    t.text     "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tolk_translations", force: :cascade do |t|
    t.integer  "phrase_id"
    t.integer  "locale_id"
    t.text     "text"
    t.text     "previous_text"
    t.boolean  "primary_updated", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tolk_translations", ["phrase_id", "locale_id"], name: "index_tolk_translations_on_phrase_id_and_locale_id", unique: true, using: :btree

  create_table "tract", primary_key: "tract_id", force: :cascade do |t|
    t.integer  "gid",                                                    default: "nextval('tract_gid_seq'::regclass)", null: false
    t.string   "statefp",  limit: 2
    t.string   "countyfp", limit: 3
    t.string   "tractce",  limit: 6
    t.string   "name",     limit: 7
    t.string   "namelsad", limit: 20
    t.string   "mtfcc",    limit: 5
    t.string   "funcstat", limit: 1
    t.float    "aland"
    t.float    "awater"
    t.string   "intptlat", limit: 11
    t.string   "intptlon", limit: 12
    t.geometry "the_geom", limit: {:srid=>4269, :type=>"multi_polygon"}
  end

  create_table "ubicaciones", force: :cascade do |t|
    t.geometry "coordenadas", limit: {:srid=>4326, :type=>"st_point"}
    t.string   "descripcion"
    t.integer  "perfil_id"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "recorrido"
    t.string   "mosaico"
    t.integer  "aerofoto"
  end

  add_index "ubicaciones", ["coordenadas"], name: "index_ubicaciones_on_coordenadas", using: :gist
  add_index "ubicaciones", ["perfil_id"], name: "index_ubicaciones_on_perfil_id", unique: true, using: :btree

  create_table "usos_de_la_tierra", force: :cascade do |t|
    t.string "valor", null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.text     "config"
    t.integer  "ficha_id",               default: 1
    t.string   "idioma",                 default: "es", null: false
  end

  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true, using: :btree
  add_index "usuarios", ["ficha_id"], name: "index_usuarios_on_ficha_id", using: :btree
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree

  create_table "usuarios_roles", id: false, force: :cascade do |t|
    t.integer "usuario_id"
    t.integer "rol_id"
  end

  add_index "usuarios_roles", ["usuario_id", "rol_id"], name: "index_usuarios_roles_on_usuario_id_and_rol_id", using: :btree

  create_table "zcta5", id: false, force: :cascade do |t|
    t.integer  "gid",                                                    default: "nextval('zcta5_gid_seq'::regclass)", null: false
    t.string   "statefp",  limit: 2,                                                                                    null: false
    t.string   "zcta5ce",  limit: 5,                                                                                    null: false
    t.string   "classfp",  limit: 2
    t.string   "mtfcc",    limit: 5
    t.string   "funcstat", limit: 1
    t.float    "aland"
    t.float    "awater"
    t.string   "intptlat", limit: 11
    t.string   "intptlon", limit: 12
    t.string   "partflg",  limit: 1
    t.geometry "the_geom", limit: {:srid=>4269, :type=>"multi_polygon"}
  end

  add_index "zcta5", ["gid"], name: "uidx_tiger_zcta5_gid", unique: true, using: :btree

  create_table "zip_lookup", primary_key: "zip", force: :cascade do |t|
    t.integer "st_code"
    t.string  "state",   limit: 2
    t.integer "co_code"
    t.string  "county",  limit: 90
    t.integer "cs_code"
    t.string  "cousub",  limit: 90
    t.integer "pl_code"
    t.string  "place",   limit: 90
    t.integer "cnt"
  end

  create_table "zip_lookup_all", id: false, force: :cascade do |t|
    t.integer "zip"
    t.integer "st_code"
    t.string  "state",   limit: 2
    t.integer "co_code"
    t.string  "county",  limit: 90
    t.integer "cs_code"
    t.string  "cousub",  limit: 90
    t.integer "pl_code"
    t.string  "place",   limit: 90
    t.integer "cnt"
  end

  create_table "zip_lookup_base", primary_key: "zip", force: :cascade do |t|
    t.string "state",   limit: 40
    t.string "county",  limit: 90
    t.string "city",    limit: 90
    t.string "statefp", limit: 2
  end

  create_table "zip_state", id: false, force: :cascade do |t|
    t.string "zip",     limit: 5, null: false
    t.string "stusps",  limit: 2, null: false
    t.string "statefp", limit: 2
  end

  create_table "zip_state_loc", id: false, force: :cascade do |t|
    t.string "zip",     limit: 5,   null: false
    t.string "stusps",  limit: 2,   null: false
    t.string "statefp", limit: 2
    t.string "place",   limit: 100, null: false
  end

end
