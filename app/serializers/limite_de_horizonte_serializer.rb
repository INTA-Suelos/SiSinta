class LimiteDeHorizonteSerializer < ActiveModel::Serializer
  with_options serializer: LookupSerializer do |l|
    l.has_one :tipo
    l.has_one :forma
  end
end
