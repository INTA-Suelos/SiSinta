class AddProvinciaToSeries < ActiveRecord::Migration
  def change
    add_reference :series, :provincia, index: true
  end
end
