# encoding: utf-8
class Ability
  include CanCan::Ability

  attr_reader :basicos, :perfiles

  def initialize(usuario = nil)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    @usuario = usuario || Usuario.new # guest user (not logged in)

    @perfiles = [Perfil, Horizonte, Analitico, Adjunto]
    @basicos = [Grupo, Fase, Proyecto, Serie]

    if @usuario.has_role? :admin
      administrador
    else
      if @usuario.has_role? :autorizado
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
      can :manage, perfiles
      can :manage, basicos
    end

    # Usuario miembro de un perfil. Usamos una acción personalizada para
    # separar la consulta sobre instancias de la consulta de clases, por
    # requisito de rolify
    def miembro
      can :modificar, Serie,  id: Serie.with_role('miembro', @usuario).map {|s| s.id}
      can :modificar, Perfil, id: Perfil.with_role('miembro', @usuario).map {|p| p.id}
      invitado
    end

    # usuario invitado, anónimo o no existente
    def invitado
      can :read, perfiles, publico: true
      can :read, basicos
    end

end
