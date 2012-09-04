FactoryGirl.define do
  factory :capacidad do
    calicata
    clase_id 1
    subclase_ids { [SubclaseDeCapacidad.first.id] }
  end
end
