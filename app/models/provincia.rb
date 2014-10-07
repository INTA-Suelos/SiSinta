# encoding: utf-8
class Provincia < Lookup
  include ActiveHash::Enum

  has_many :series

  field :valor
  field :slug

  enum_accessor :slug

  alias_attribute :nombre, :valor
end
