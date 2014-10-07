# encoding: utf-8
class Serie < ActiveRecord::Base
  # Permite utilizar roles sobre este modelo
  resourcify :roles, role_cname: 'Rol'

  has_many :perfiles
  has_one :perfil_modal, ->{ where(modal: true) }, class_name: 'Perfil'
  belongs_to :usuario

  has_lookup :provincia

  accepts_nested_attributes_for :perfiles

  validates_uniqueness_of :nombre, :simbolo, scope: :provincia_id,
    allow_blank: true, allow_nil: true
  # TODO validar que haya provincia_id cuando los datos estén sanos
  validates_presence_of :nombre

  def self.ransackable_attributes(auth_object = nil)
    super(auth_object) - ['created_at', 'updated_at', 'perfil_id', 'id']
  end
end
