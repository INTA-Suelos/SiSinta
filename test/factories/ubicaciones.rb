# encoding: utf-8
FactoryGirl.define do
  factory :ubicacion do
    perfil
    descripcion "alguna descripción.."

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
