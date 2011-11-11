class CreateJoinCapacidadSubclase < ActiveRecord::Migration
  def up

    # Debería ser así, pero no anda por algún error de la librería
    # create_table "capacidad_subclase_capacidad", :id => false, :force => true do |t|
    #   t.column "capacidad_id", :integer
    #   t.column "capacidad_subclase_id", :integer
    # end

    execute("create table capacidad_subclase_capacidad (capacidad_id integer not null, capacidad_subclase_id integer not null)")
  end

  def down
    drop_table "capacidad_subclase_capacidad"
  end
end
