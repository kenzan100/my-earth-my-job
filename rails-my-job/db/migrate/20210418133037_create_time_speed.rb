class CreateTimeSpeed < ActiveRecord::Migration[6.1]
  def change
    create_table :time_speeds do |t|
      t.datetime :starting
      t.datetime :ending
      t.integer  :multiplier

      t.timestamps
    end
  end
end
