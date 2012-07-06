# encoding: utf-8
class Ability
  include CanCan::Ability

  attr_reader :basicos

  def initialize(usuario)
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

    usuario ||= Usuario.new # guest user (not logged in)

    @basicos = [Calicata, Horizonte, Analisis, Adjunto, Grupo, Fase]

    if usuario.admin?
      can :manage, :all
    else
      if usuario.autorizado?
        can :manage, basicos
      else
        # usuario invitado, anónimo o no existente
        can :read, basicos, publico: true
      end
    end

  end
end
