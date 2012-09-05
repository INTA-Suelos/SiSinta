# encoding: utf-8
FactoryGirl.define do
  sequence :cadena_unica, 'a'

  sequence :porcentaje do |n|
    rand(100) * 0.01
  end

  sequence :email do |n|
    "mail-numero-#{n}@falso.com"
  end

  # Hay varios modelos que pueden o no tener una calicata asociada
  trait :sin_calicata do
    calicata nil
  end
end
