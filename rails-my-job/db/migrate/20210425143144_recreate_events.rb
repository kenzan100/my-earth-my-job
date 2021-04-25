class RecreateEvents < ActiveRecord::Migration[6.1]
  def change
    rename_column(:events, :equipment_id, :eventable_id)
    add_column(:events, :eventable_type, :string)
  end
end
