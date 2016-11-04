# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :consistencia_en_seco, aliases: [:en_seco] do
    valor { generate :cadena_unica }
  end
end
