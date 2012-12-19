# encoding: utf-8
require './test/test_helper'

class RolTest < ActiveSupport::TestCase

  test "debería poder agregar miembros a los perfiles" do
    usuario = create(:usuario)
    perfil = create(:perfil)
    usuario.grant :miembro, perfil
    assert usuario.has_role? :miembro, perfil
  end

end
