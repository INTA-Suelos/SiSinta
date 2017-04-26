# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :formato_de_coordenadas do
    srid { rand(100) }
    descripcion { generate :cadena_unica }
  end
end
