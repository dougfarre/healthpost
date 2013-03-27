class CreateTransferCenters < ActiveRecord::Migration
  def change
    create_table :transfer_centers do |t|
      t.string :name

      t.timestamps
    end
  end
end
