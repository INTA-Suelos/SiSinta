class ProcesamientoDecorator < ApplicationDecorator
  decorates_association :perfiles

  def created_at
    source.created_at.to_s :dma_hms
  end
end
