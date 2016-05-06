class CheckFichaDefault < ActiveRecord::Migration
  def up
    Ficha.find_by(identificador: 'clasico').try :update_attribute, :default, true
  end

  def down
    Ficha.find_by(identificador: 'clasico').try :update_attribute, :default, false
  end
end
