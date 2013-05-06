class ConsistenciaSerializer < ActiveModel::Serializer
  with_options serializer: LookupSerializer do |l|
    l.has_one :en_seco
    l.has_one :en_humedo
    l.has_one :adhesividad
    l.has_one :plasticidad
  end
end
