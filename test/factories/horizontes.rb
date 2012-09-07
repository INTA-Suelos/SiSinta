# encoding: utf-8
FactoryGirl.define do
  factory :horizonte do
    calicata
    sequence(:profundidad_superior) { |n| n + 4 }
    profundidad_inferior { profundidad_superior + 2 }
    ph 1.5
  end
end
