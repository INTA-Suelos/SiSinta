# encoding: utf-8
FactoryGirl.define do
  factory :capacidad do
    perfil
    clase_id 1
    subclase_ids { [SubclaseDeCapacidad.first.id] }
  end
end
