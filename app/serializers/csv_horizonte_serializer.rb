class CSVHorizonteSerializer < HorizonteSerializer
  has_one :perfil, serializer: CSVPerfilSerializer

  def to_csv(columnas = [])
    lista = HashWithIndifferentAccess.new(self.serializable_hash).sort.flatten_tree

    # FIXME Si por default usamos toda la lista, no podemos saber si al
    # serializar se agregan columnas (capacidad, humedad) por lo que los
    # headers quedan desfasados. Solución: generar un stub completísimo o no
    # exportar nada si no se selecciona nada.
    if columnas.any?(&:present?)
      lista.select { |i| columnas.include? i }
    else
      lista
    end.values
  end
end
