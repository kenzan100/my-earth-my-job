class RenameRate < ActiveRecord::Migration[6.1]
  def change
    rename_column :equipment, :rate, :hourly_rate
  end
end
