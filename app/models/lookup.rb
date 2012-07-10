# encoding: utf-8
class Lookup < ActiveYaml::Base
  include ActiveHash::Associations

  # Guardo en semillas todos los .yml con los datos de las clases que heredan de
  # Lookup. Cada una busca el plural de su nombre acá.
  set_root_path "db/semillas"

  def to_str
    valor
  end

end
