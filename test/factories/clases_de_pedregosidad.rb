# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :clase_de_pedregosidad do
    valor { generate :cadena_unica }
  end
end
