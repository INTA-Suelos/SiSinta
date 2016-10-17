FactoryGirl.define do
  factory :consistencia_en_humedo, aliases: [:en_humedo] do
    valor { generate :cadena_unica }
  end
end
