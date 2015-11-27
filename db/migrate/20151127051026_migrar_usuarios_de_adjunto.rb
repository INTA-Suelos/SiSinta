class MigrarUsuariosDeAdjunto < ActiveRecord::Migration
  def up
    Adjunto.find_each do |adjunto|
      adjunto.update_attribute :usuario_id, adjunto.perfil.usuario_id
    end
  end

  def down
    Adjunto.update_all usuario_id: nil
  end
end
