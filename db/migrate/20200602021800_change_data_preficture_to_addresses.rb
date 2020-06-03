class ChangeDataPrefictureToAddresses < ActiveRecord::Migration[5.2]
  def change
    change_column :addresses, :preficture, :integer
  end
end