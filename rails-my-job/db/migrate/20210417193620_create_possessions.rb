class CreatePossessions < ActiveRecord::Migration[6.1]
  def change
    create_table :possessions do |t|
      t.integer :quantity
      t.belongs_to :good, foreign_key: true
      t.timestamps
    end
  end
end
