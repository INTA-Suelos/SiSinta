class Ficha < ActiveRecord::Base
  validates :nombre, presence: true
  validates :identificador, presence: true

  def self.default
    Ficha.find_by identificador: 'completa'
  end
end
