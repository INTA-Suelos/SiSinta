class FixProvinciaIds < ActiveRecord::Migration
  def up
    # Salta, de 1 a 16
    Serie.where(provincia_id: 1).update_all provincia_id: 16
    # Buenos Aires, de 2 a 1
    Serie.where(provincia_id: 2).update_all provincia_id: 1
    # Entre Rios, de 5 a 8
    Serie.where(provincia_id: 5).update_all provincia_id: 8
    # Santa Fe, de 17 a 20
    Serie.where(provincia_id: 17).update_all provincia_id: 20
    # Corrientes, de 21 a 6
    Serie.where(provincia_id: 21).update_all provincia_id: 6
    # Córdoba, de 22 a 7
    Serie.where(provincia_id: 22).update_all provincia_id: 7
    # Jujuy, de 23 a 10
    Serie.where(provincia_id: 23).update_all provincia_id: 10
  end

  def down
    Serie.where(provincia_id: 10).update_all provincia_id: 23
    Serie.where(provincia_id: 7).update_all provincia_id: 22
    Serie.where(provincia_id: 6).update_all provincia_id: 21
    Serie.where(provincia_id: 20).update_all provincia_id: 17
    Serie.where(provincia_id: 8).update_all provincia_id: 5
    Serie.where(provincia_id: 1).update_all provincia_id: 2
    Serie.where(provincia_id: 16).update_all provincia_id: 1
  end
end
