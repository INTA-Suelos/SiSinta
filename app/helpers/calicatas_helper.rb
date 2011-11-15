# -*- encoding : utf-8 -*-
module CalicatasHelper
  def tildada?(s)
    @calicata.capacidad.subclases.include?(s)
  end
end
