# encoding: utf-8
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
