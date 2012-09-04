# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fase do
    codigo { generate :cadena_unica }
    nombre { generate :cadena_unica }
  end
end
