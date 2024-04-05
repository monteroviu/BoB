class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.references :questionnaire, foreign_key: true
      t.references :group, foreign_key: true
      t.references :student, foreign_key: true
      t.string "token", null: false
      t.boolean "approved", default: true, null: false

      t.timestamps
    end
  end
end
