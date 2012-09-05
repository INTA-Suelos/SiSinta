# encoding: utf-8
FactoryGirl.define do
  factory :estructura do
    horizonte
    tipo_id   { rand(14) + 1 }
    clase_id  { rand(4)  + 1 }
    grado_id  { rand(2)  + 1 }
  end
end
