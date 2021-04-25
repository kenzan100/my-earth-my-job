class RecreateAttributes < ActiveRecord::Migration[6.1]
  def change
    create_table :good_attributes do |t|
      t.string :name, null: false
      t.belongs_to :good, foreign_key: true
      t.timestamps
    end
  end
end
