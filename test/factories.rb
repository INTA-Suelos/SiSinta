# encoding: utf-8
# Para falsear uploads en rack entre otras cosas
include ActionDispatch::TestProcess

FactoryGirl.define do
  sequence :cadena_unica, 'a'

  sequence :porcentaje do
    rand(100) * 0.01
  end

  sequence :email do |n|
    "mail-numero-#{n}@falso.com"
  end

  # Hay varios modelos que pueden o no tener un perfil asociado
  trait :sin_perfil do
    perfil nil
  end

  # TODO agregar todos los campos en las fábricas
end
