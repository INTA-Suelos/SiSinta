# -*- encoding : utf-8 -*-
class Horizonte < ActiveRecord::Base
  has_one :analisis,      :dependent => :destroy, :inverse_of => :horizonte
  has_one :color,         :dependent => :destroy, :inverse_of => :horizonte
  has_one :limite,        :dependent => :destroy, :inverse_of => :horizonte
  has_one :consistencia,  :dependent => :destroy, :inverse_of => :horizonte
  has_one :estructura,    :dependent => :destroy, :inverse_of => :horizonte

  has_many :texturas, :through => :analisis

  belongs_to :calicata, :inverse_of => :horizontes

  accepts_nested_attributes_for :analisis, :color, :limite, :consistencia,
                                :estructura

  validates_presence_of :calicata
end
