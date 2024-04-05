class AddExcelFileToGroups < ActiveRecord::Migration[5.2]
  def change
    add_attachment :groups, :excel
  end
end
