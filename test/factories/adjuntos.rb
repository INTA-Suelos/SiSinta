# encoding: utf-8
# https://stackoverflow.com/questions/13673639/accessing-session-from-a-helper-spec-in-rspec#comment35259918_13673639
FactoryGirl.define do
  factory :adjunto do
    perfil
    archivo do
      # https://stackoverflow.com/questions/13673639/accessing-session-from-a-helper-spec-in-rspec#comment35259918_13673639
      Rack::Test::UploadedFile.new(
        Rails.root.join('app', 'assets', 'images', 'sisinta.png'), 'image/png'
      )
    end
    notas { generate :cadena_unica }
  end
end
