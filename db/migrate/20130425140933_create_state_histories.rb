class CreateStateHistories < ActiveRecord::Migration
  def change
    create_table :state_histories do |t|
      t.integer :request_id
      t.string :state
      t.string :notes

      t.timestamps
    end
  end
end
