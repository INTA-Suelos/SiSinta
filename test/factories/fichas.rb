FactoryGirl.define do
  factory :ficha do
    nombre { generate :cadena_unica }
    identificador { generate :cadena_unica }
  end
end
