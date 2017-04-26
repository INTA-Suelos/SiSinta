# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :equipo do
    nombre { generate :cadena_unica }

    transient { miembros 0 }

    after(:build) do |equipo, params|
      params.miembros.times do
        equipo.miembros << build(:usuario)
      end
    end
  end
end
