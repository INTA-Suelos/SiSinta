class AddCantidadDePerfilesToSerie < ActiveRecord::Migration
  def change
    add_column :series, :cantidad_de_perfiles, :integer, default: 0, null: false

    begin
      Serie.reset_column_information
      Serie.select(:id).all.each do |id|
        Serie.reset_counters(id, :perfiles)
      end
    rescue
      # Nada
    end
  end
end
