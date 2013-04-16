class Fixadddiagnosistorequest < ActiveRecord::Migration
  def up
    rename_column :requests, :diagnosis, :diagnosis_id
    rename_column :requests, :diagnosis_detail, :diagnosis_detail_id
  end

  def down
  end
end
