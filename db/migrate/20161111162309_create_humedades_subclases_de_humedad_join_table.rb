class CreateHumedadesSubclasesDeHumedadJoinTable < ActiveRecord::Migration
  def change
    create_join_table :humedades, :subclases_de_humedad do |t|
      t.index [:subclase_de_humedad_id, :humedad_id], unique: true, name: 'subclases_humedades'
    end
  end
end
