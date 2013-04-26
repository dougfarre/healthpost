class Addusertostatehistories < ActiveRecord::Migration
  def up
    add_column :state_histories, :user_id, :integer
  end

  def down
  end
end
