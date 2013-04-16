class Addphonetoproviders < ActiveRecord::Migration
  def up
    add_column :providers, :phone, :string
  end

  def down
  end
end
