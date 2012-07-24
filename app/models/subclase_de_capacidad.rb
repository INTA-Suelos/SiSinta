# encoding: utf-8
class SubclaseDeCapacidad < Lookup
  se_asocia_con :capacidades, como: :subclase

  def to_str
    codigo
  end

end
