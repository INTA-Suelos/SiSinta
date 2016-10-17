FactoryGirl.define do
  factory :forma_de_limite do
    valor { generate :cadena_unica }
  end
end
