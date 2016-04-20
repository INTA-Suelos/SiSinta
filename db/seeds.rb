# En este archivo va la carga inicial de datos. La mayoría de estos datos
# residen en db/semillas/, en diferentes archivos y formatos. Acá se realiza la
# carga.
require 'csv'
require 'seeds_helper'

include SeedsHelper

load 'db/semillas/admin.rb'
load 'db/semillas/colores.rb'
load 'db/semillas/fichas.rb'
