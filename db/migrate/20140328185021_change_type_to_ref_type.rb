class ChangeTypeToRefType < ActiveRecord::Migration
  def change
  	change_column :references, :type, :ref_type
  end
end
