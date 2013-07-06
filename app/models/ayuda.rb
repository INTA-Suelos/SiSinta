# encoding: utf-8
class Ayuda < Lookup
  include ActiveHash::Enum

  # Declarar los campos para los que ActiveHash debe pregenerar finders
  field :campo

  # Garantiza que 'campo' sea único y genera constantes del tipo Ayuda::CAMPO
  enum_accessor :campo

  def to_s
    ayuda
  end
end
