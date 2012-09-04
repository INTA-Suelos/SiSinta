# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :calicata do
    nombre { generate :cadena_unica }
    fecha "2012-09-03"

    factory :calicata_modal do
      modal true
      simbolo { generate :cadena_unica }
    end

    factory :calicata_anonima do
      nombre nil
    end

    factory :calicata_futura do
      fecha { 2.days.from_now }
    end
  end
end
