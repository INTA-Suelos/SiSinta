# Modelo de consulta de la información geográfica de las provincias de
# Argentina, según el IGN.
class IgnProvincia < ApplicationRecord
  # Relacionado 1 a 1 con una Provincia
  has_one :provincia, as: :data_oficial

  # Columna con la información geográfica (los polígonos)
  def self.poligonos
    arel_table[:geog]
  end
end
