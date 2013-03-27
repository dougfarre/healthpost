class AddUserFieldsToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :user_created_by, :integer
    add_column :requests, :user_updated_by, :integer
  end
end
