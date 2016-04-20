class Ficha < ActiveRecord::Base
  validates :nombre, presence: true, uniqueness: true
  validates :identificador, presence: true, uniqueness: true

  def self.default
    Ficha.find_by identificador: 'completa'
  end
end
