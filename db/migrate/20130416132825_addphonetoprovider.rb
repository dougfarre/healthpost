class Addphonetoprovider < ActiveRecord::Migration
  def up
    add_column :practices, :phone, :string
  end

  def down
  end
end
