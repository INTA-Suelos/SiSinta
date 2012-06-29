class Ayuda < Lookup
  include ActiveHash::Enum

  # Lo declaro para que ActiveHash genere el finder
  field :campo

  # Garantiza que 'campo' sea único y genera constantes del tipo Ayuda::CAMPO
  enum_accessor :campo
end
