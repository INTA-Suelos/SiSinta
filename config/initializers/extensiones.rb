# Requerimos los archivos en lib/extensiones
require 'extension_modelos'
require 'has_lookups'
require 'has_lookups/ransackables'

# Muestra la fecha como 02/11/2012. Se usa con Date.to_s(:dma)
Date::DATE_FORMATS[:dma] = "%d/%m/%Y"
