# encoding: utf-8
# Redefine ransackable_attributes y ransackable_associations para tratar a los
# lookups como un valor y no como una asociación
module HasLookups::Ransackables
  extend ActiveSupport::Concern

  module ClassMethods
    # Redefine los atributos ransackeables para sacar los lookup_id y agregar
    # los ransackers
    def ransackable_attributes(auth_object = nil)
      self.column_names - self.lookups.map {|e| e + '_id'} + _ransackers.keys
    end

    # Redefine las asociaciones ransackeables para sacar los lookups, que más
    # que como asociación se comportan como valor
    def ransackable_associations(auth_object = nil)
      reflect_on_all_associations.map {|a| a.name.to_s} - self.lookups
    end
  end
end
