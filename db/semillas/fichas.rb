# Las diferentes plantillas de carga que entiende el sistema
[
  { nombre: 'Formulario clásico de Etchevere', identificador: 'clasico' },
  { nombre: 'Formulario Provincia de Corrientes', identificador: 'corrientes' }
].each do |ficha|
  Ficha.find_or_create_by nombre: ficha[:nombre], identificador: ficha[:identificador]
end
