# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :pedregosidad do
    clase_id 1
    subclase_id 1
  end
end
