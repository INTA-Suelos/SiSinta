# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :rol do
    name 'Invitado'

    trait :administrador do
      name 'Administrador'
    end

    trait :autorizado do
      name 'Autorizado'
    end
  end
end
