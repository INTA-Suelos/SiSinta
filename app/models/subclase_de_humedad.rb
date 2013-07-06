# encoding: utf-8
class SubclaseDeHumedad < Lookup
  se_asocia_con :humedades, como: :subclase

  # Declarar los campos para los que ActiveHash debe pregenerar finders
  field :valor
end
