class CreatePersistedAttributesTables < ActiveRecord::Migration[7.1]
  def change
    create_table :persisted_attributes_attributes do |t|
      t.references :record, polymorphic: true, null: false
      t.string :name
      t.string :type
      t.string :value

      t.timestamps
    end
  end
end
