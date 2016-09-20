class CSVHorizonteSerializer < HorizonteSerializer
  has_one :perfil, serializer: CSVPerfilSerializer

  def to_csv(columnas = [])
    lista = HashWithIndifferentAccess.new(self.serializable_hash).sort.flatten_tree

    if columnas.any?(&:present?)
      lista.select { |i| columnas.include? i }
    else
      lista
    end.values
  end
end
