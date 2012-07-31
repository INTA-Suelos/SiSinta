class CalicataDecorator < Draper::Base
  decorates :calicata
  decorates_association :ubicacion
end
