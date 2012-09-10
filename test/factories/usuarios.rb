# encoding: utf-8
FactoryGirl.define do
  factory :usuario do
    nombre { generate :cadena_unica }
    email
    password "algún password inolvidable"

    trait :administrador do
      roles { [ create(:rol, :administrador) ] }
    end

    trait :autorizado do
      roles { [ create(:rol, :autorizado) ] }
    end

    trait :invitado do
      roles { [ create(:rol) ] }
    end
  end
end
