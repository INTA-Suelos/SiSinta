# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :adjunto do
    perfil
    archivo do
      Rack::Test::UploadedFile.new(
        Rails.root.join('app', 'assets', 'images', 'sisinta.png'), 'image/png'
      )
    end
    notas { generate :cadena_unica }
  end
end
