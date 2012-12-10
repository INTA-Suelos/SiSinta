# encoding: utf-8
class Color < ActiveRecord::Base
  attr_accessible :hvc

  has_many :horizontes_en_seco, class_name: 'Color', inverse_of: :color_seco
  has_many :horizontes_en_humedo, class_name: 'Color', inverse_of: :color_humedo

  def to_s
    hvc
  end

  # TODO rgb nil? aproximar
end
