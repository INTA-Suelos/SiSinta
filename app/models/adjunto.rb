# encoding: utf-8
class Adjunto < ActiveRecord::Base
  belongs_to :calicata, :inverse_of => :adjuntos
  has_attached_file :archivo, { url: '/estaticos/:id/:filename',
                                path: Rails.configuration.adjunto_path }

  def extension
    File.extname(archivo.path).delete('.')
  end

  def to_s
    archivo.try(:path)
  end

end
