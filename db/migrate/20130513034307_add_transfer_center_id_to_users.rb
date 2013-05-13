class AddTransferCenterIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :transfer_center_id, :integer
  end
end
