# encoding: utf-8
class Consistencia < ActiveRecord::Base
  belongs_to :horizonte, :inverse_of => :consistencia

  validates_presence_of :horizonte
end
