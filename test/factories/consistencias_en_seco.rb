FactoryGirl.define do
  factory :consistencia_en_seco, aliases: [:en_seco] do
    valor { generate :cadena_unica }
  end
end
