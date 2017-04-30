# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :paisaje do
    tipo { generate :cadena_unica }
    forma { generate :cadena_unica }
    simbolo { generate :cadena_unica }
  end
end
