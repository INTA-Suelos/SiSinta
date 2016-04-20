# Las diferentes plantillas de carga que entiende el sistema
[
  { nombre: 'Formulario clásico de Etchevere',
  identificador: 'completa' }
].each do |ficha|
  Ficha.find_or_create_by nombre: ficha[:nombre], identificador: ficha[:identificador]
end
