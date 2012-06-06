class Lookup < ActiveRecord::Base
  def to_str
    self.try(:valor1).to_s
  end
end
