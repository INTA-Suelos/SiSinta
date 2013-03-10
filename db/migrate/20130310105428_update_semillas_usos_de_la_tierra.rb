class UpdateSemillasUsosDeLaTierra < ActiveRecord::Migration
  def up
    Perfil.where(
      'uso_de_la_tierra_id > 2').update_all(
        'uso_de_la_tierra_id = uso_de_la_tierra_id + 2')
  end

  def down
    Perfil.where(
      'uso_de_la_tierra_id > 4').update_all(
        'uso_de_la_tierra_id = uso_de_la_tierra_id - 2')
  end
end
