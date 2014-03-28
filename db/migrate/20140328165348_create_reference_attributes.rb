class CreateReferenceAttributes < ActiveRecord::Migration
  def change
    create_table :reference_attributes do |t|
      t.integer :reference_id
      t.text :name
      t.text :value

      t.timestamps
    end
  end
end
