# encoding: utf-8
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
