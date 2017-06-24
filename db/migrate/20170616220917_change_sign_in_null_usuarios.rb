class ChangeSignInNullUsuarios < ActiveRecord::Migration
  def change
    change_column_null :usuarios, :sign_in_count, false
  end
end
