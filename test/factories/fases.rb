# encoding: utf-8
FactoryGirl.define do
  factory :fase do
    codigo { generate :cadena_unica }
    nombre { generate :cadena_unica }
  end
end
