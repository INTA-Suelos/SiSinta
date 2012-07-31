class AddDeviseToUsuarios < ActiveRecord::Migration
  def self.up
    change_table(:usuarios) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps
    end

    add_index :usuarios, :email,                :unique => true
    add_index :usuarios, :reset_password_token, :unique => true
    # add_index :usuarios, :confirmation_token,   :unique => true
    # add_index :usuarios, :unlock_token,         :unique => true
    # add_index :usuarios, :authentication_token, :unique => true
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    # raise ActiveRecord::IrreversibleMigration

    remove_index :usuarios, :email
    remove_index :usuarios, :reset_password_token

    remove_column :usuarios, :password_digest
    remove_column :usuarios, :email
    remove_column :usuarios, :encrypted_password
    remove_column :usuarios, :reset_password_token
    remove_column :usuarios, :reset_password_sent_at
    remove_column :usuarios, :remember_created_at
    remove_column :usuarios, :sign_in_count
    remove_column :usuarios, :current_sign_in_at
    remove_column :usuarios, :last_sign_in_at
    remove_column :usuarios, :current_sign_in_ip
    remove_column :usuarios, :last_sign_in_ip
  end
end
