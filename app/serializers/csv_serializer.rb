# encoding: utf-8
class CSVSerializer < ActiveModel::ArraySerializer
  def as_csv(*args)
    o = args.extract_options!

    CSV.generate(headers: o[:headers]) do |csv|
      csv << encabezado(o[:checks]) if csv.headers
      object.each do |perfil|
        perfil.horizontes.each do |horizonte|
          csv << CSVHorizonteSerializer.new(horizonte).to_csv(o[:checks])
        end
      end
    end
  end

  def encabezado(columnas = nil)
    lista = HashWithIndifferentAccess.new(stub.serializable_hash).sort.flatten_tree
    if columnas.present?
      lista.select {|i| columnas.include? i}
    else
      lista
    end.keys
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

      # TODO desacoplar
      s.horizontes.build
      s.preparar
      CSVHorizonteSerializer.new(s.horizontes.first)
    end
end
