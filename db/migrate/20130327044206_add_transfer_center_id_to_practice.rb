class AddTransferCenterIdToPractice < ActiveRecord::Migration
  def change
    add_column :practices, :transfer_center_id, :integer
  end
end
