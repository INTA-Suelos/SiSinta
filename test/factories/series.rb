# encoding: utf-8
FactoryGirl.define do
  factory :serie do
    nombre  { generate :cadena_unica }
    simbolo { generate :cadena_unica }

    factory :serie_anonima do
      nombre nil
    end
  end
end
