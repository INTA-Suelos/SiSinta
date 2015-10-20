# encoding: utf-8
FactoryGirl.define do
  factory :paisaje do
    tipo { generate :cadena_unica }
    forma { generate :cadena_unica }
    simbolo { generate :cadena_unica }
  end
end
