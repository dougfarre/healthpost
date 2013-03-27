class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.string :name

      t.timestamps
    end
  end
end
