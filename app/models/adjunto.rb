# encoding: utf-8
class Adjunto < ActiveRecord::Base
  belongs_to :perfil, inverse_of: :adjuntos
  has_attached_file :archivo, {
    url: '/system/:class/:id/:filename',
    path: Rails.configuration.adjunto_path,
    # No verificar que el tipo de archivo coincida con la extensión
    validate_media_type: false
  }

  validates_attachment :archivo, file_type_ignorance: true

  delegate :publico, :usuario, :usuario_id, to: :perfil

  def extension
    File.extname(archivo.path.to_s).delete('.')
  end
end
