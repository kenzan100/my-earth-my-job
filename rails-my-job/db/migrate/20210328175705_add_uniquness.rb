class AddUniquness < ActiveRecord::Migration[6.1]
  def change
    add_index(:equipment, :name, unique: true)
  end
end
