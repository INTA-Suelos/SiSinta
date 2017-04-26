# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :consistencia_en_humedo, aliases: [:en_humedo] do
    valor { generate :cadena_unica }
  end
end
