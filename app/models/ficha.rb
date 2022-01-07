class Ficha < ApplicationRecord
  validates :nombre, presence: true, uniqueness: true
  validates :identificador, presence: true, uniqueness: true

  def self.default
    where(default: true).first || Ficha.first
  end
end
