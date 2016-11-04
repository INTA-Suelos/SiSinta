# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :humedad do
    clase_id 1
    subclase_ids { Array.wrap((rand(4) + 1).times.collect { rand(4) + 1 }).uniq }
  end
end
