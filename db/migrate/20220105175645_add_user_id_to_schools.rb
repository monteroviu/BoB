class AddUserIdToSchools < ActiveRecord::Migration[5.2]
  def change
    add_reference :schools, :user, foreign_key: true
  end
end
