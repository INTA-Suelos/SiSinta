class Paisaje < ActiveRecord::Base
  belongs_to :calicata, :inverse_of => :paisaje

  validates_presence_of :calicata

  def to_s
    "#{tipo}-#{forma}-#{simbolo}"
  end

end
