class Proyecto < ActiveRecord::Base
  belongs_to :usuario
  has_and_belongs_to_many :perfiles

  accepts_nested_attributes_for :perfiles, allow_destroy: true

  validates_uniqueness_of :nombre
  validates_presence_of   :nombre

  def self.ransackable_attributes(auth_object = nil)
    super(auth_object) - ['created_at', 'updated_at', 'perfil_id', 'id']
  end
end
