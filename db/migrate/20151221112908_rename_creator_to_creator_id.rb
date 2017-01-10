class RenameCreatorToCreatorId < ActiveRecord::Migration
  def change
    rename_column :goals, :creator, :creator_id
  end
end
