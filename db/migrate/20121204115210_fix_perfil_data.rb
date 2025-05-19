class FixPerfilData < ActiveRecord::Migration

  class Perfil < ApplicationRecord
    belongs_to :serie
  end

  class Serie < ApplicationRecord
    has_many :perfiles
  end

  def up
    add_column :perfiles, :serie_id, :integer

    # Por cada perfil modal una serie con su nombre.
    Perfil.reset_column_information
    Serie.reset_column_information
    Perfil.all.each do |p|
      s = Serie.find_or_create_by_nombre(p.nombre)
      s.simbolo = p.simbolo
      s.perfiles << p
    end
  end

  def down
    remove_column :perfiles, :serie_id
  end
end
