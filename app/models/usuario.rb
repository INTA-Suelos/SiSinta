class Usuario < ActiveRecord::Base
  has_and_belongs_to_many :roles, :inverse_of => :usuarios
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :nombre, :email, :password, :password_confirmation, :remember_me, :ficha

  def usa_ficha_simple?
    self.ficha == 'simple' ? true : false
  end

  def admin?
    self.roles.exists?({nombre: 'admin'})
  end

end
