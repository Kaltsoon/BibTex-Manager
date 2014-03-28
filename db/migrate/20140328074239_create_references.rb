class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.text :type
      t.text :name

      t.timestamps
    end
  end
end
