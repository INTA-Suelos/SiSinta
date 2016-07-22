FactoryGirl.define do
  factory :escurrimiento do
    valor { generate :cadena_unica }
  end
end
