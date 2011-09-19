class Usuario < ActiveRecord::Base
  def usar_ficha_simple?
    self.ficha_simple
  end
end
