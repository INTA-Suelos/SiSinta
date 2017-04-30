# Los valores posibles para Clase de Capacidad en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
clases = [
  { id: 1, codigo: 'I',
    descripcion: 'sin limitaciones',
    categoria: 'tierras aptas para todo tipo de cultivo' },
  { id: 2, codigo: 'II',
    descripcion: 'ligeras limitaciones',
    categoria: 'tierras aptas para todo tipo de cultivo' },
  { id: 3, codigo: 'III',
    descripcion: 'moderadas limitaciones',
    categoria: 'tierras aptas para todo tipo de cultivo' },
  { id: 4, codigo: 'IV',
    descripcion: 'severas limitaciones',
    categoria: 'tierras aptas para cultivos limitados' },
  { id: 5, codigo: 'V',
    descripcion: 'dificultad de maquinaria',
    categoria: 'tierras generalmente no aptas para cultivos' },
  { id: 6, codigo: 'VI',
    descripcion: 'praderas naturales con posibles mejoras',
    categoria: 'tierras generalmente no aptas para cultivos' },
  { id: 7, codigo: 'VII',
    descripcion: 'pasturas naturales',
    categoria: 'tierras generalmente no aptas para cultivos' },
  { id: 8, codigo: 'VIII',
    descripcion: 'fauna, vida silvestre',
    categoria: 'tierras generalmente no aptas para cultivos' }
]

clases.each do |clase|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless ClaseDeCapacidad.exists?(clase[:id])
    ClaseDeCapacidad.find_or_create_by(clase).update_column(:id, clase[:id])
  end
end
