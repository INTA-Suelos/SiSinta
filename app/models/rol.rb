# encoding: utf-8
class Rol < ApplicationRecord
  has_and_belongs_to_many :usuarios, join_table: :usuarios_roles
  belongs_to :resource, polymorphic: true

  alias_attribute :nombre, :name

  scopify

  scope :globales, ->{ where(resource: nil) }

  def to_param
    nombre
  end
end
