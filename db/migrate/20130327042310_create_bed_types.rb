class CreateBedTypes < ActiveRecord::Migration
  def change
    create_table :bed_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
