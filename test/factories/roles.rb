# encoding: utf-8
FactoryGirl.define do
  factory :rol do
    nombre "invitado"

    trait :admin do
      nombre "administrador"
    end

    trait :autorizado do
      nombre "autorizado"
    end
  end
end
