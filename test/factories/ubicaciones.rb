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
  end
end
