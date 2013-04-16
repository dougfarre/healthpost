class Addprovidertouser < ActiveRecord::Migration
  def up
    add_column :users, :provider_id, :integer
  end

  def down
  end
end
