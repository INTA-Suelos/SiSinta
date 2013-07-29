# encoding: utf-8
class Color < ActiveRecord::Base
  attr_accessible :hvc

  has_many :horizontes_en_seco, class_name: 'Color', inverse_of: :color_seco
  has_many :horizontes_en_humedo, class_name: 'Color', inverse_of: :color_humedo

  validates_presence_of :hvc
  validates_uniqueness_of :hvc
  # TODO validate_format_of :hvc

  # TODO rgb nil? aproximar
end
