class CreateHospitalPreferences < ActiveRecord::Migration
  def change
    create_table :hospital_preferences do |t|
      t.integer :request_id
      t.integer :hospital_id

      t.timestamps
    end
  end
end
