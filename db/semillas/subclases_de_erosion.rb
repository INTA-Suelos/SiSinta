# Los valores posibles para SubclaseDeErosion en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
subclases_de_erosion = [
  { id: 1, valor: 'hídrica' },
  { id: 2, valor: 'eólica' },
  { id: 3, valor: 'acumulación' }
]

subclases_de_erosion.each do |subclase_de_erosion|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless SubclaseDeErosion.exists?(subclase_de_erosion[:id])
    SubclaseDeErosion.find_or_create_by(subclase_de_erosion).update_column(:id, subclase_de_erosion[:id])
  end
end
