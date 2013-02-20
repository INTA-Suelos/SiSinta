# encoding: utf-8
FactoryGirl.define do
  factory :equipo do
    nombre { generate :cadena_unica }
  end
end
