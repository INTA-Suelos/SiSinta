# En este archivo va la carga inicial de datos. La mayoría de estos datos
# residen en db/semillas/, en diferentes archivos y formatos. Acá se realiza la
# carga.
require 'csv'
require 'seeds_helper'

include SeedsHelper

load 'db/seeds/admin.rb'
load 'db/seeds/roles.rb'
load 'db/semillas/colores.rb'
load 'db/semillas/fichas.rb'

# Datos "fijos" o de lookup
load 'db/semillas/drenajes.rb'
load 'db/semillas/escurrimientos.rb'
load 'db/semillas/pendientes.rb'
load 'db/semillas/permeabilidades.rb'
load 'db/semillas/relieves.rb'
load 'db/semillas/anegamientos.rb'
load 'db/semillas/usos_de_la_tierra.rb'
load 'db/semillas/posiciones.rb'
load 'db/semillas/sales.rb'
load 'db/semillas/texturas.rb'
load 'db/semillas/provincias.rb'
load 'db/semillas/clases_de_erosion.rb'
load 'db/semillas/subclases_de_erosion.rb'
load 'db/semillas/formas_de_limite.rb'
load 'db/semillas/tipos_de_limite.rb'
load 'db/semillas/consistencias_en_seco.rb'
load 'db/semillas/consistencias_en_humedo.rb'
load 'db/semillas/plasticidades.rb'
load 'db/semillas/adhesividades.rb'
load 'db/semillas/clases_de_capacidad.rb'
load 'db/semillas/subclases_de_capacidad.rb'
load 'db/semillas/clases_de_humedad.rb'
load 'db/semillas/subclases_de_humedad.rb'
load 'db/semillas/clases_de_estructura.rb'
load 'db/semillas/grados_de_estructura.rb'
load 'db/semillas/tipos_de_estructura.rb'
load 'db/semillas/clases_de_pedregosidad.rb'
load 'db/semillas/subclases_de_pedregosidad.rb'
load 'db/semillas/formatos_de_coordenadas.rb'
