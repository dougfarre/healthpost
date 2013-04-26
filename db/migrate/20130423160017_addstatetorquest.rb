class Addstatetorquest < ActiveRecord::Migration
  def up
    add_column :requests, :aasm_state, :string
  end

  def down
  end
end
