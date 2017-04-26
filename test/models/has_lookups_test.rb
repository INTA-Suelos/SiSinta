require './test/test_helper'

class HasLookupsTest < ActiveSupport::TestCase

  setup do
    @lookups = {  }
  end

  test "define asociaciones con lookups" do
    @lookups.each_pair do |modelo, lookups|
      clase = modelo.to_s.classify.constantize
      lookups.each do |lookup|
        assert clase.new.respond_to?(lookup),
          "no asocia #{lookup} en #{modelo}"
      end
    end
  end

  test "define ransackeables" do
    @lookups.each_pair do |modelo, lookups|
      clase = modelo.to_s.classify.constantize
      lookups.each do |lookup|
        assert clase._ransackers.keys.include?(lookup),
          "no ransackea #{lookup} en #{modelo}"
      end
    end
  end

  test "mantiene la lista de lookups" do
    @lookups.each_pair do |modelo, lookups|
      clase = modelo.to_s.classify.constantize
      lookups.each do |lookup|
        assert clase.lookups.include?(lookup),
          "no incluye #{lookup} en la lista de lookups de #{modelo}"
      end
    end
  end

  test "arregla las listas de atributos de Ransack" do
    @lookups.each_pair do |modelo, lookups|
      clase = modelo.to_s.classify.constantize
      lookups.each do |lookup|
        assert clase.ransackable_attributes.include?(lookup),
          "no agrega #{lookup} como atributo ransackeable para #{modelo}"
        refute clase.ransackable_attributes.include?("#{lookup}_id"),
          "no remueve #{lookup}_id como atributo ransackeable para #{modelo}"
      end
    end
  end

  test "arregla las listas de asociaciones de Ransack" do
    @lookups.each_pair do |modelo, lookups|
      clase = modelo.to_s.classify.constantize
      lookups.each do |lookup|
        refute clase.ransackable_associations.include?(lookup),
          "no agrega #{lookup} como atributo ransackeable para #{modelo}"
      end
    end
  end
end
