# encoding: utf-8
# Inspiración: http://stackoverflow.com/a/10715242/1325155
# Opciones:
#   - separador: un caracter para separar padre e hijo
module Enumerable
  def flatten_tree(prefijo_del_padre = nil)
    hash = {}

    self.each_with_index do |elem, index|
      if elem.is_a?(Array)
        k, v = elem
      else
        k, v = index, elem
      end

      # assign key name for result hash
      key = prefijo_del_padre ? "#{prefijo_del_padre}_#{k}" : k

      if v.is_a? Enumerable
        # Recursión!
        hash.merge!(v.flatten_tree(key))
      else
        hash[key] = v
      end
    end

    hash
  end
end
