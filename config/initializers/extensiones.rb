# Cargar las librerías de lib/*
require 'extension_modelos'
require 'nulificar_asociacion'
require 'has_lookups'
require 'has_lookups/ransackables'
require 'flatten_tree'
require 'ransack_helper'

# Muestra la fecha como 02/11/2012. Se usa con Date.to_s(:dma)
Date::DATE_FORMATS[:dma] = "%d/%m/%Y"
Date::DATE_FORMATS[:dma_corta] = "%d/%m/%y"
