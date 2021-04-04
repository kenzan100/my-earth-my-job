class AddDitractorToJobAttributes < ActiveRecord::Migration[6.1]
  def change
    add_column :job_attributes, :ditractor, :boolean, default: false
  end
end
