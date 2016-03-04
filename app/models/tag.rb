class Tag < ActsAsTaggableOn::Tag
  # Cargar las etiquetaciones
  scope :con_taggings, ->{ joins(:taggings) }

  # Tipos de tags
  scope :reconocedores, ->{ con_taggings.where(taggings: { context: 'reconocedores' }) }
  scope :etiquetas, ->{ con_taggings.where(taggings: { context: 'etiquetas' }) }
end
