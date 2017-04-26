# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :grupo do
    codigo { generate :cadena_unica }
    descripcion { generate :cadena_unica }
  end
end
