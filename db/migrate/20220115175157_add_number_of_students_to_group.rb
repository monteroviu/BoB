class AddNumberOfStudentsToGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :number_of_students, :integer, default:0
  end
end
