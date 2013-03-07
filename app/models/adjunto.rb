# encoding: utf-8
class Adjunto < ActiveRecord::Base
  attr_accessible :archivo, :notas
  belongs_to :perfil, inverse_of: :adjuntos
  has_attached_file :archivo, { url: '/estaticos/:id/:filename',
                                path: Rails.configuration.adjunto_path }

  delegate :publico, to: :perfil, allow_nil: true

  def extension
    File.extname(archivo.path).delete('.')
  end

  def to_s
    archivo.try(:path)
  end

end
