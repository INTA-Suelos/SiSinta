# -*- encoding : utf-8 -*-
class AddHorizonteForeignKey < ActiveRecord::Migration
  def change
    add_column :horizontes, :observacion_id, :integer
  end
end
