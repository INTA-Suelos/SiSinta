# encoding: utf-8
FactoryGirl.define do
  factory :consistencia do
    horizonte
    en_seco_id      { rand(5) + 1 }
    en_humedo_id    { rand(5) + 1 }
    adhesividad_id  { rand(3) + 1 }
    plasticidad_id  { rand(3) + 1 }
  end
end
