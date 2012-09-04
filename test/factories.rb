FactoryGirl.define do
  sequence :cadena_unica, 'a'

  trait :sin_calicata do
    calicata nil
  end
end
