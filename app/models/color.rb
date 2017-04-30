# encoding: utf-8
class Color < ActiveRecord::Base
  has_many :horizontes_en_seco,
    class_name: 'Horizonte', inverse_of: :color_seco, foreign_key: :color_seco_id
  has_many :horizontes_en_humedo,
    class_name: 'Horizonte', inverse_of: :color_humedo, foreign_key: :color_humedo_id

  validates :hvc, presence: true, uniqueness: true
  # TODO validate_format_of :hvc

  # TODO rgb nil? aproximar
end
