# -*- encoding : utf-8 -*-
class Horizonte < ActiveRecord::Base
  has_one :analisis, :dependent => :destroy
  has_one :color, :dependent => :destroy
  has_one :consistencia, :dependent => :destroy
  belongs_to :observacion
end
