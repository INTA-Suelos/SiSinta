# encoding: utf-8
FactoryGirl.define do
  factory :busqueda do
    nombre { generate :cadena_unica }

    trait :publica do
      publico true
    end

    # Feo pero así funciona. Busca los perfiles con id < 10
    trait :primeros_perfiles do
      consulta 'g' => {
        '0' => {
          'c' => {
            '1' => {
              'a' => { '0' => { 'name' => 'id' } },
              'p' => 'lt',
              'v' => { '0' => { 'value' => '10' } }
            }
          },
          'm' => 'and'
        }
      }
    end
  end
end
