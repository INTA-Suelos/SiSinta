# encoding: utf-8
class Adjunto < ActiveRecord::Base
  attr_accessible :archivo, :notas
  belongs_to :perfil, inverse_of: :adjuntos
  has_attached_file :archivo, { url: '/estaticos/:id/:filename',
                                path: Rails.configuration.adjunto_path }

  validates_attachment :archivo, file_type_ignorance: true

  delegate :publico, :usuario, :usuario_id, to: :perfil

  def extension
    File.extname(archivo.path).delete('.')
  end
end
