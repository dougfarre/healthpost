class Addpracticetorequest < ActiveRecord::Migration
  def up
    add_column :requests, :practice_id, :integer
  end

  def down
  end
end
