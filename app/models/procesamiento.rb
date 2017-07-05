class Procesamiento < ActiveRecord::Base
  METODOLOGIAS = [
    'slabs.R'
  ]

  belongs_to :usuario
  has_and_belongs_to_many :perfiles, validate: false

  has_attached_file :imagen, {
    url: '/system/:class/:attachment/:style/:id_partition/:filename',                                                                                                                                                         

    # No verificar que el tipo de archivo coincida con la extensión
    validate_media_type: false
  }

  validates_attachment :imagen, file_type_ignorance: true
end
