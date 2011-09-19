# -*- encoding : utf-8 -*-
class Horizonte < ActiveRecord::Base
  has_one :analisis, :dependent => :destroy
  belongs_to :observacion
end
