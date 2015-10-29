# encoding: utf-8
FactoryGirl.define do
  factory :capacidad do
    clase_id 1
    subclase_ids { Array.wrap((rand(4) + 1).times.collect { rand(4) + 1 }).uniq }
  end
end
