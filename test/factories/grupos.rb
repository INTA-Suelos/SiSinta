# encoding: utf-8
FactoryGirl.define do
  factory :grupo do
    codigo { generate :cadena_unica }
    descripcion { generate :cadena_unica }
  end
end
