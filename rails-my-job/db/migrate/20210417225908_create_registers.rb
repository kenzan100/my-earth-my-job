class CreateRegisters < ActiveRecord::Migration[6.1]
  def change
    create_table :registers do |t|
      t.time :start_hour
      t.time :end_hour
      t.references :registerable, polymorphic: true

      t.timestamps
    end
  end
end
