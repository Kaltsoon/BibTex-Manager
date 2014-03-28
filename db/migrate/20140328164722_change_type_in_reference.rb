class ChangeTypeInReference < ActiveRecord::Migration
  def change
  	rename_column :references, :type, :ref_type
  end
end
