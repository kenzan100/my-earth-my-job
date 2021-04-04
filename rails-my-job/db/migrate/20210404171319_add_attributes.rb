class AddAttributes < ActiveRecord::Migration[6.1]
  def change
    create_table :job_attributes do |t|
      t.string :name, null: false
      t.boolean :binary, default: false
      t.float :required_months
      t.timestamps
    end

    create_table :my_attributes do |t|
      t.string :name, null: false
      t.float :spent_months
      t.timestamps
    end
  end
end
