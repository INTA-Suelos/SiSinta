# Agregar mensajes de error del recurso al flash.actions de InheritedResources
# https://github.com/activeadmin/activeadmin/issues/3335#issuecomment-73110516
class ActiveAdmin::BaseController
  protected

  def interpolation_options
    options = {}

    options[:resource_errors] =
      if resource && resource.errors.any?
        "#{resource.errors.full_messages.to_sentence}."
      else
        ""
      end

    options
  end
end
