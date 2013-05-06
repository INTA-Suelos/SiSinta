class CSVSerializer < ActiveModel::ArraySerializer
  def as_csv(*args)
    o = args.extract_options!

    CSV.generate(headers: o[:headers]) do |csv|
      csv << encabezado(o[:checks]) if csv.headers
      object.each do |recurso|
        csv << recurso.active_model_serializer.new(recurso).to_csv(o[:checks])
      end
    end
  end

  def encabezado(columnas)
    hash = HashWithIndifferentAccess.new(stub.serializable_hash)
    hash.sort.select {|i| columnas.include? i.first}.flatten_tree.keys
  end

  private

    # Construye un objeto con todas las asociaciones iniciadas para determinar
    # los nombres de columnas del csv a partir de las llaves del hash
    def stub
      s = begin
        object.first
      rescue NoMethodError
        object
      end.class.new.decorate

      # TODO desacoplar de Perfil
      s.horizontes.build
      s.active_model_serializer.new(s.preparar)
    end
end
