# encoding: utf-8
FactoryGirl.define do
  factory :usuario do
    nombre { generate :cadena_unica }
    email
    password "algún password inolvidable"

    trait :admin do
      roles { [Rol.find_by_nombre('administrador')] }
    end
  end
end
