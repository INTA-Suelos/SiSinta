FactoryGirl.define do
  factory :tipo_de_limite do
    valor { generate :cadena_unica }
  end
end
