# -*- encoding : utf-8 -*-
module ExtensionModelos

# Métodos de instancia

  #
  # Construye los objetos asociados al modelo, para usar con el +FormHelper+, si es que no
  # existen ya.
  #
  # * *Args*    :
  #   - +asociaciones+ -> la lista de asociaciones que construir
  # * *Returns* :
  #   - el modelo con las asociaciones preparadas
  #
  def preparar(asociaciones)
    asociaciones.each do |asociacion|
      self.send("build_#{asociacion}") if self.send(asociacion).nil?
    end
    return self
  end

end

# Autoinclusión de la extensión
ActiveRecord::Base.send(:include, ExtensionModelos)
