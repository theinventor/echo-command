class User < ActiveRecord::Base
  has_many :authentications

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def nickname
   authentications.first.try(:nickname)
  end

  def authentication
    authentications.first
  end

  def echo_user
    authentications.first.try(:echo_user)
  end
end
