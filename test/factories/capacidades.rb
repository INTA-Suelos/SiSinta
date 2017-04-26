# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :capacidad do
    perfil

    transient { con_subclases 0 }

    after(:create) do |capacidad, params|
      params.con_subclases.times do
        capacidad.subclases << build(:subclase_de_capacidad)
      end
    end
  end
end
