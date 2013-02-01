class ProyectoDecorator < ApplicationDecorator
  decorates :proyecto
  decorates_association :perfiles
end
