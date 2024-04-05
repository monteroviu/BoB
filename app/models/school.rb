class School < ApplicationRecord
  belongs_to :user
  has_many  :groups, dependent: :destroy
  has_many :students, through: :groups

  validates :name, presence: {message: "El nombre de la escuela no puede estar en blanco"}, uniqueness: { scope: :user_id , message: "El nombre de la escuela debe ser único"}
end
