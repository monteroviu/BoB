class AddRequestedAtToInvitations < ActiveRecord::Migration[5.2]
  def change
    add_column :invitations, :requested_at, :datetime
  end
end
