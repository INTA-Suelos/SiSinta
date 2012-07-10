class MejoresNombres < ActiveRecord::Migration
  def change
    rename_column :calicatas, :uso_tierra_id, :uso_de_la_tierra_id

    rename_table  :capacidad_subclases_capacidades,
                    :capacidades_subclases_de_capacidad
    rename_column :capacidades_subclases_de_capacidad,
                    :capacidad_subclase_id, :subclase_de_capacidad_id

    rename_column :capacidades, :capacidad_clase_id, :clase_de_capacidad_id

    rename_column :horizontes, :textura_horizonte_id, :textura_de_horizonte_id

    rename_column :limites, :limite_tipo_id, :tipo_de_limite_id
    rename_column :limites, :limite_forma_id, :forma_de_limite_id
  end
end
