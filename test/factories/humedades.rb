# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :humedad do
    perfil

    transient { con_subclases 0 }

    trait :con_clase do
      association :clase, factory: :clase_de_humedad
    end

    after(:create) do |humedad, params|
      params.con_subclases.times do
        humedad.subclases << build(:subclase_de_humedad)
      end
    end
  end
end
