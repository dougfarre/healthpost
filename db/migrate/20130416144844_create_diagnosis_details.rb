class CreateDiagnosisDetails < ActiveRecord::Migration
  def change
    create_table :diagnosis_details do |t|
      t.string :name
      t.integer :diagnosis_id

      t.timestamps
    end
  end
end
