# Los valores posibles para Textura en cada Horizonte de la ficha de perfiles.
# La clasificación de los suelos según su textura proviene de
# http://www.miliarium.com/Paginas/Prontu/Tablas/Suelos/ClasesTexturales.htm

texturas = [
  { id: 1, clase: 'arenoso', textura: 'textura gruesa', suelo: 'suelos arenosos' },
  { id: 2, clase: 'areno franco', textura: 'textura gruesa', suelo: 'suelos arenosos' },
  { id: 3, clase: 'franco arenoso', textura: 'textura moderadamente gruesa', suelo: 'suelos francos' },
  { id: 4, clase: 'franco', textura: 'textura media', suelo: 'suelos francos' },
  { id: 5, clase: 'franco limoso', textura: 'textura media', suelo: 'suelos francos' },
  { id: 6, clase: 'limoso', textura: 'textura media', suelo: 'suelos francos' },
  { id: 7, clase: 'franco arcillo arenoso', textura: 'textura moderadamente fina', suelo: 'suelos francos' },
  { id: 8, clase: 'franco arcilloso', textura: 'textura moderadamente fina', suelo: 'suelos francos' },
  { id: 9, clase: 'franco arcillo limoso', textura: 'textura moderadamente fina', suelo: 'suelos francos' },
  { id: 10, clase: 'arcillo arenoso', textura: 'textura fina', suelo: 'suelos arcillosos' },
  { id: 11, clase: 'arcillo limoso', textura: 'textura fina', suelo: 'suelos arcillosos' },
  { id: 12, clase: 'arcilloso', textura: 'textura fina', suelo: 'suelos arcillosos' }
]

texturas.each do |textura|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless Textura.exists?(textura[:id])
    Textura.find_or_create_by(textura).update_column(:id, textura[:id])
  end
end
