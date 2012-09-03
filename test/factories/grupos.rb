# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :grupo do
    codigo { generate :cadena_unica }
    descripcion { generate :cadena_unica }
  end
end
