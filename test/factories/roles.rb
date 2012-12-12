# encoding: utf-8
FactoryGirl.define do
  factory :rol do
    name "invitado"

    trait :administrador do
      name "administrador"
    end

    trait :autorizado do
      name "Autorizado"
    end
  end
end
