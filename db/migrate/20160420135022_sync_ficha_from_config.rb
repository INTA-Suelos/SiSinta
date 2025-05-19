class Usuario < ApplicationRecord
  store :config, accessors: [:ficha]
end

class SyncFichaFromConfig < ActiveRecord::Migration
  def up
    Usuario.find_each do |u|
      u.update_attribute :ficha_id, Ficha.find_by(identificador: u.ficha).try(:id)
    end
  end

  def down
    Usuario.update_all ficha_id: nil
  end
end
