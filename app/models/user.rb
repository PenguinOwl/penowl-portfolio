class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  def user_flags
    flags = UserFlag.where(user: id)
    res = []
    flags.each do |flag|
      res << flag.content.to_sym
    end
    return res
  end

end
