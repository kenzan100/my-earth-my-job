class CreateEquipment < ActiveRecord::Migration[6.1]
  def change
    create_table :equipment do |t|
      t.string :name
      t.float :rate
      t.string :timestamps

      t.timestamps
    end
  end
end
