# encoding: utf-8
FactoryGirl.define do
  factory :perfil do
    numero  { generate :cadena_unica }
    fecha   { 2.days.ago }

    factory :perfil_futuro do
      fecha { 2.days.from_now }
    end
  end
end
