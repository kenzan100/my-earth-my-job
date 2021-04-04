class AddEquipmentIdToJobAttributes < ActiveRecord::Migration[6.1]
  def change
    add_column :job_attributes, :equipment_id, :integer
  end
end
