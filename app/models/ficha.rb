class Ficha < ActiveRecord::Base
  def self.default
    Ficha.find_by identificador: 'completa'
  end
end
