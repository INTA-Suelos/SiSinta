# Serializa una estructura según los valores de sus 3 campos
#
# { 
#   tipo: "algún tipo",
#   clase: "alguna clase"
#   grado: "algún grado"
# }
class EstructuraSerializer < ActiveModel::Serializer
  # Todas las asociaciones de estructura son un modelo lookup con un sólo valor
  with_options serializer: LookupSerializer do |l|
    l.has_one :tipo
    l.has_one :clase
    l.has_one :grado
  end
end
