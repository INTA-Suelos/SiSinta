# encoding: utf-8
FactoryGirl.define do
  factory :proyecto do
    nombre { generate :cadena_unica }
    descripcion 'algo maravilloso!!'
    cita '1968. Ed. Gurbo. Salvo, Juan.'
  end
end
