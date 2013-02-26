# encoding: utf-8
FactoryGirl.define do
  factory :adjunto do
    perfil
    archivo do
      fixture_file_upload(
        Rails.root.join('app', 'assets', 'images', 'sisinta.png'), 'image/png'
      )
    end
    notas { generate :cadena_unica }
  end
end
