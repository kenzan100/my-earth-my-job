class AddStatus < ActiveRecord::Migration[6.1]
  def change
    add_column :equipment, :status, :integer
  end
end
