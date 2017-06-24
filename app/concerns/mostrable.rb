# Define métodos genéricos para incluir en los modelos que son value object,
# específicamente los que tienen un método `valor`.
module Mostrable
  extend ActiveSupport::Concern

  # ActiveAdmin usa este método para mostrar el modelo en algunas partes como
  # filtros o títulos
  def display_name
    "#{model_name.human}: #{valor}"
  end
end
