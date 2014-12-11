# encoding: utf-8
FactoryGirl.define do
  factory :usuario do
    nombre { generate :cadena_unica }
    email
    password 'algún password inolvidable'

    transient { rol nil }
    after(:build) do |usuario, params|
      usuario.grant(params.rol) if params.rol
    end
  end
end
