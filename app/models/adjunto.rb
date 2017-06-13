# Recopila información sobre un archivo adjunto a un perfil
class Adjunto < ActiveRecord::Base
  belongs_to :perfil, inverse_of: :adjuntos
  belongs_to :usuario, inverse_of: :adjuntos

  has_attached_file :archivo, {
    url: '/system/:class/:id/:filename',
    path: Rails.configuration.adjunto_path,
    # No verificar que el tipo de archivo coincida con la extensión
    validate_media_type: false
  }

  validates_attachment :archivo, file_type_ignorance: true

  before_save :sincronizar_visibilidad_perfil

  def extension
    File.extname(archivo.path.to_s).delete('.')
  end

  def sincronizar_visibilidad_perfil
    self.publico = perfil.publico if perfil.present?

    # Siempre anda
    return true
  end
end
