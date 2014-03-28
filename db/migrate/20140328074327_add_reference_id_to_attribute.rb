class AddReferenceIdToAttribute < ActiveRecord::Migration
  def change
  	add_column :attributes, :referende_id, :integer
  end
end
