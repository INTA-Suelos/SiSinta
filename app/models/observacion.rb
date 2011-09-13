class Observacion < ActiveRecord::Base
  has_many :horizontes, :dependent => :destroy
end
