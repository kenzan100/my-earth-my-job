class CreateReferences < ActiveRecord::Migration[6.1]
  def change
    create_table :references do |t|
      t.text :url, null: false
      t.references :referencible, polymorphic: true
      t.timestamps
    end
  end
end
