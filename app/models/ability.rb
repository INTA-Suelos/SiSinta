# encoding: utf-8
class Ability
  include CanCan::Ability

  attr_reader :basicos, :perfiles, :recursos

  def initialize(usuario = nil)
    @usuario = usuario || Usuario.new

    @perfiles = [ Perfil, Horizonte, Analitico, Adjunto, Erosion, Ubicacion,
                  Humedad, Paisaje, Pedregosidad, Limite, Consistencia,
                  Estructura, Busqueda ]
    @basicos =  [ Grupo, Fase, Color, Proyecto, Serie, Equipo ]
    @recursos = @perfiles + @basicos

    alias_action  :autocomplete_usuario_nombre,
                  :autocomplete_usuario_email,
                  :autocomplete_grupo_descripcion,
                  :autocomplete_fase_nombre,
                  :autocomplete_reconocedores_name,
                  :autocomplete_etiquetas_name,
                  :autocomplete_serie_nombre,
                  :autocomplete_serie_simbolo,
                  :autocomplete_color_rgb,
                  :autocomplete_color_hvc,
                  :seleccionar,
                  :derivar,
                  :almacenar,
                  :exportar,
                  :procesar,                              to: :read
    alias_action  :editar_analiticos, :update_analiticos, to: :update

    if @usuario.admin?
      administrador
    else
      if @usuario.autorizado?
        autorizado
      # Si no tiene permisos globales, ver de qué recursos es miembro
      elsif @usuario.persisted?
        miembro
      else
        invitado
      end
    end
  end

  # Lógica de cada rol
  private

    # FIXME Que no sea el único que puede acceder a los datos de usuarios
    def administrador
      can :manage, :all
    end

    def autorizado
      can :read, recursos
      can :create, recursos
      can :manage, perfiles, usuario_id: @usuario.id
      can :manage, [ Equipo, Proyecto, Serie ], usuario_id: @usuario.id
      can :update, Equipo, miembros: { id: @usuario.id }
    end

    # Usuario miembro de un perfil. Usamos una acción personalizada para
    # separar la consulta sobre instancias de la consulta de clases, por
    # requisito de rolify
    def miembro
      [Serie, Perfil].each do |recurso|
        can :modificar, recurso,  id: recurso.with_role('Miembro', @usuario).map {|s| s.id}
      end

      # Los miembros de algo pueden autocompletar los reconocedores y etiquetas
      can :autocomplete_reconocedores_name, Perfil
      can :autocomplete_etiquetas_name, Perfil

      # Todos los miembros tienen permisos de invitados
      invitado
    end

    # usuario invitado, anónimo o no existente
    def invitado
      can :read, perfiles, publico: true
      can :read, basicos
      can :create, Busqueda
    end
end
