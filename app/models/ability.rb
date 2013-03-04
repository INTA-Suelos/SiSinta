# encoding: utf-8
class Ability
  include CanCan::Ability

  attr_reader :basicos, :perfiles, :recursos

  def initialize(usuario = nil)
    @usuario = usuario || Usuario.new

    @perfiles = [ Perfil, Horizonte, Analitico, Adjunto, Erosion, Ubicacion,
                  Humedad, Paisaje, Pedregosidad, Limite, Consistencia,
                  Estructura, Color ]
    @basicos =  [ Grupo, Fase, Proyecto, Serie ]
    @recursos = @perfiles + @basicos

    alias_action :autocompletar, :exportar, to: :read
    alias_action :editar_analiticos, :update_analiticos, to: :update
    alias_action :permitir, to: :manage

    if @usuario.admin?
      administrador
    else
      if @usuario.autorizado?
        autorizado
      else
        miembro
      end
    end

  end

  # Lógica de cada rol
  private

    def administrador
      can :manage, :all
    end

    def autorizado
      can :read, recursos
      can :create, recursos
      can :manage, perfiles, usuario_id: @usuario.id
      can :manage, [ Proyecto, Serie ], usuario_id: @usuario.id
    end

    # Usuario miembro de un perfil. Usamos una acción personalizada para
    # separar la consulta sobre instancias de la consulta de clases, por
    # requisito de rolify
    def miembro
      [Serie, Perfil].each do |recurso|
        can :modificar, recurso,  id: recurso.with_role('Miembro', @usuario).map {|s| s.id}
      end
      invitado
    end

    # usuario invitado, anónimo o no existente
    def invitado
      can :read, perfiles, publico: true
      can :read, basicos
    end

end
