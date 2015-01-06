# encoding: utf-8
class Fase < ApplicationRecord
  has_many :perfiles

  validates :codigo,
    uniqueness: { allow_blank: true, allow_nil: true },
    length: { maximum: 2 }
  validates :nombre,
    uniqueness: true,
    presence: true

  accepts_nested_attributes_for :perfiles
end
