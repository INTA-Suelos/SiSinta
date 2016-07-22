FactoryGirl.define do
  factory :permeabilidad do
    valor { generate :cadena_unica }
  end
end
