class AdelgazarPerfiles < ActiveRecord::Migration

  class Perfil < ActiveRecord::Base
    belongs_to :serie
  end

  class Serie < ActiveRecord::Base
    has_many :perfiles
  end

  def up
    change_table :perfiles do |t|
      t.remove :nombre
      t.remove :simbolo
    end
  end

  def down
    change_table :perfiles do |t|
      t.string :nombre
      t.string :simbolo
    end
    # Recupero los nombres de los perfiles a partir de la serie a la que
    # pertenecen.
    Perfil.reset_column_information
    Serie.all.each do |s|
      s.perfiles.each do |p|
        p.nombre = s.nombre
        p.simbolo = s.simbolo
        p.save
      end
    end
  end
end
