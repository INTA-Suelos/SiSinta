class Serie < ActiveRecord::Base
  has_many :calicatas, :inverse_of => :serie do
    def modal
      where('modal = ?', true).first
    end
  end

  validates_uniqueness_of :simbolo, :allow_blank => true
  validates_uniqueness_of :nombre
  validates_presence_of :nombre
end
