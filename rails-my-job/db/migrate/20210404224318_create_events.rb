class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.integer :status_changed_to
      t.integer :equipment_id
      t.timestamps
    end
  end
end
