class CreateHospitalBedAvailabilities < ActiveRecord::Migration
  def change
    create_table :hospital_bed_availabilities do |t|
      t.integer :request_id
      t.integer :hospital_id
      t.integer :bed_type_id

      t.timestamps
    end
  end
end
