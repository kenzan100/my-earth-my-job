class CreateSpends < ActiveRecord::Migration[6.1]
  def change
    create_table :spends do |t|
      t.belongs_to :good, foreign_key: true
      t.timestamps
    end
  end
end
