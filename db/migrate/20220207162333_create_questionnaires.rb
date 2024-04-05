class CreateQuestionnaires < ActiveRecord::Migration[5.2]
  def change
    create_table :questionnaires do |t|
      t.string :code
      t.string :name
      t.text :description
      t.text :regards
      t.text :thanks

      t.timestamps
    end
  end
end
