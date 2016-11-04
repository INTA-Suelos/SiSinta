# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :proyecto do
    nombre { generate :cadena_unica }
    descripcion 'algo maravilloso!!'
    cita '1968. Ed. Gurbo. Salvo, Juan.'
  end
end
