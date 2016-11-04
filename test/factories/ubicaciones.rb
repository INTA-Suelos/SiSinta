# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :ubicacion do
    trait :vieja_escuela do
      mosaico '3760-2-2'
      recorrido 'mmm..'
      aerofoto '1'
    end

    trait :con_coordenadas do
      coordenadas 'POINT(45.0 55.0)'
    end
  end
end
