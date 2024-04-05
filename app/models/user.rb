class User < ApplicationRecord
  has_many :schools, dependent: :destroy
  has_many :groups, through: :schools
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
