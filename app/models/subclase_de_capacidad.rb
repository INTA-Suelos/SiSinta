# encoding: utf-8
class SubclaseDeCapacidad < Lookup
  se_asocia_con :capacidades, como: :subclase

  # Declarar los campos para los que ActiveHash debe pregenerar finders
  field :valor
end
