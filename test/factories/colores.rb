# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :color do
    hvc '10B 1/1'
    rgb 'rgb(22, 30, 36)'
  end
end
