# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :color, aliases: [:color_seco, :color_humedo] do
    hvc "10B 1/1"
    rgb { "rgb(#{rand(255)}, 30, 36)" }
  end
end
