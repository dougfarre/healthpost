class CreateBedPreferences < ActiveRecord::Migration
  def change
    create_table :bed_preferences do |t|
      t.integer :request_id
      t.integer :bed_type_id

      t.timestamps
    end
  end
end
