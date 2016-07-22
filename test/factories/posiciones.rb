FactoryGirl.define do
  factory :posicion do
    valor { generate :cadena_unica }
  end
end
