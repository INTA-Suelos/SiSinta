# Una serie agrupa lógicamente un conjunto de perfiles. Tiene un perfil modal
# (que puede no ser una calicata existente), que representa el perfil más común
# de la serie
class Serie < ActiveRecord::Base
  # Permite utilizar roles sobre este modelo
  resourcify :roles, role_cname: 'Rol'

  has_many :perfiles
  has_one :perfil_modal, ->{ where(modal: true) }, class_name: 'Perfil'
  belongs_to :usuario
  belongs_to :provincia

  accepts_nested_attributes_for :perfiles

  # TODO validate :provincia, presence: true (cuando los datos estén sanos)
  validates :nombre,
    uniqueness: { scope: :provincia_id, allow_blank: true, allow_nil: true },
    presence: true
  validates :simbolo,
    uniqueness: { scope: :provincia_id, allow_blank: true, allow_nil: true }

  def self.ransackable_attributes(auth_object = nil)
    super(auth_object) - ['created_at', 'updated_at', 'perfil_id', 'id']
  end
end
