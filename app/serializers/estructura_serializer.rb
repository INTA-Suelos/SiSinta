# encoding: utf-8
class EstructuraSerializer < ActiveModel::Serializer
  with_options serializer: LookupSerializer do |l|
    l.has_one :tipo
    l.has_one :clase
    l.has_one :grado
  end
end
