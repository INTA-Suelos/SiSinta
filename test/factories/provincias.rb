FactoryGirl.define do
  factory :provincia do
    nombre { generate :cadena_unica }
  end
end
