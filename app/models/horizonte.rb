# -*- encoding : utf-8 -*-
class Horizonte < ActiveRecord::Base
  after_initialize :preparar

  has_one :analisis,      :dependent => :destroy, :inverse_of => :horizonte
  has_one :limite,        :dependent => :destroy, :inverse_of => :horizonte
  has_one :consistencia,  :dependent => :destroy, :inverse_of => :horizonte
  has_one :estructura,    :dependent => :destroy, :inverse_of => :horizonte

  has_many :texturas, :through => :analisis

  belongs_to :calicata, :inverse_of => :horizontes

  belongs_to :color_seco, class_name: 'Color', inverse_of: :horizontes_en_seco
  belongs_to :color_humedo, class_name: 'Color', inverse_of: :horizontes_en_humedo

  accepts_nested_attributes_for :analisis, :limite, :consistencia,
                                :estructura, :limit => 1

  validates_presence_of :calicata

  def preparar
    super(%w{color_seco color_humedo limite consistencia estructura analisis})
  end

end
