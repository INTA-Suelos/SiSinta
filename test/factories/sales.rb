FactoryGirl.define do
  factory :sal do
    valor { generate :cadena_unica }
  end
end
