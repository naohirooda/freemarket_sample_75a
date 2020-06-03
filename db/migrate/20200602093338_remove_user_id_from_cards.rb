class RemoveUserIdFromCards < ActiveRecord::Migration[5.2]
  def change
    remove_column :cards, :user_id, :integer
  end
end
