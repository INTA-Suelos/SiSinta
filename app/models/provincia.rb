# encoding: utf-8
class Provincia < Lookup
  include ActiveHash::Enum

  has_many :series

  field :valor
  field :slug

  enum_accessor :slug

  alias_attribute :nombre, :valor
  # La foreign key de IgnProvincia
  alias_attribute :gid, :ign_provincia_id

  # Reemplazar por :belongs_to cuando convierta Provincia a ActiveRecord
  def ign_provincia
    IgnProvincia.find_by gid: ign_provincia_id
  end
end
