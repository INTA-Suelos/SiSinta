# encoding: utf-8
FactoryGirl.define do
  factory :perfil do
    nombre { generate :cadena_unica }
    numero { generate :cadena_unica }
    fecha "2012-09-03"

    factory :perfil_modal do
      modal true
      simbolo { generate :cadena_unica }
    end

    factory :perfil_anonimo do
      nombre nil
    end

    factory :perfil_futuro do
      fecha { 2.days.from_now }
    end
  end
end
