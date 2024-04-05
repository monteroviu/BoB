class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :name
      t.string :email
      t.integer :status, default:0
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
