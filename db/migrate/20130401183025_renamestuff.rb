class Renamestuff < ActiveRecord::Migration
  def up
    rename_column :users, :provider_id, :practice_id
  end

  def down
  end
end
