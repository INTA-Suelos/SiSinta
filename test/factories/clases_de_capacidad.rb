# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :clase_de_capacidad do
    codigo { generate :cadena_unica }
  end
end
