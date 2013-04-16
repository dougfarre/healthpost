class Adddiagnosistorequest < ActiveRecord::Migration
  def up
    add_column :requests, :diagnosis, :integer
    add_column :requests, :diagnosis_detail, :integer
  end

  def down
  end
end
