class FixActiveHashForeignKeys < ActiveRecord::Migration
  def up
    rename_column :estructuras, :tipo_de_estructura_id, :tipo_id
    rename_column :estructuras, :clase_de_estructura_id, :clase_id
    rename_column :estructuras, :grado_de_estructura_id, :grado_id

    rename_column :capacidades, :clase_de_capacidad_id, :clase_id

    rename_column :horizontes, :textura_de_horizonte_id, :textura_id

    rename_column :limites, :tipo_de_limite_id, :tipo_id
    rename_column :limites, :forma_de_limite_id, :forma_id
  end

  def down
    rename_column :estructuras, :tipo_id, :tipo_de_estructura_id
    rename_column :estructuras, :clase_id, :clase_de_estructura_id
    rename_column :estructuras, :grado_id, :grado_de_estructura_id

    rename_column :capacidades, :clase_id, :clase_de_capacidad_id

    rename_column :horizontes, :textura_id, :textura_de_horizonte_id

    rename_column :limites, :tipo_id, :tipo_de_limite_id
    rename_column :limites, :forma_id, :forma_de_limite_id
  end
end
