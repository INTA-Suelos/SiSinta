# encoding: utf-8
FactoryGirl.define do
  sequence :cadena_unica, 'a'

  sequence :email do |n|
    "mail-numero-#{n}@falso.com"
  end

  # Hay varios modelos que pueden o no tener una calicata asociada
  trait :sin_calicata do
    calicata nil
  end
end
