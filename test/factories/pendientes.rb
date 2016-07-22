FactoryGirl.define do
  factory :pendiente do
    valor { generate :cadena_unica }
  end
end
