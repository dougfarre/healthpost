class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :provider_id
      t.integer :transfer_center_id
      t.string :provider_callback_phone
      t.string :patient_name_first
      t.string :patient_name_last
      t.datetime :patient_dob
      t.string :patient_ssn
      t.string :complaint
      t.boolean :physician_flag

      t.timestamps
    end
  end
end
