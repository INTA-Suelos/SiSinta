# encoding: utf-8
require './test/test_helper'

class RolTest < ActiveSupport::TestCase

  test "agrega miembros a los perfiles" do
    usuario = create(:usuario)
    perfil = create(:perfil)
    usuario.grant 'Miembro', perfil
    assert usuario.has_role? 'Miembro', perfil
  end

end
