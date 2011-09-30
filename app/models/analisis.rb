class Analisis < ActiveRecord::Base
  has_one :textura, :dependent => :destroy
  belongs_to :horizonte
end
