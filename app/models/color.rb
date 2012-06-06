class Color < ActiveRecord::Base
  has_many :horizontes_en_seco, class_name: 'Color', inverse_of: :color_seco
  has_many :horizontes_en_humedo, class_name: 'Color', inverse_of: :color_humedo

  def to_s
    self.try(:hvc).to_s
  end
end
