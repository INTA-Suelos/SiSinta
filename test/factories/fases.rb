# encoding: utf-8
FactoryGirl.define do
  factory :fase do
    codigo { generate(:cadena_unica).slice(0, 2) }
    nombre { generate :cadena_unica }
  end
end
