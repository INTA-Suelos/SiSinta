# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :capacidad do
    perfil

    transient { con_subclases 0 }

    trait :con_clase do
      association :clase, factory: :clase_de_capacidad
    end

    after(:create) do |capacidad, params|
      params.con_subclases.times do
        capacidad.subclases << build(:subclase_de_capacidad, :completa)
      end
    end
  end
end
