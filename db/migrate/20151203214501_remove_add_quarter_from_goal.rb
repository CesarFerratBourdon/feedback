class RemoveAddQuarterFromGoal < ActiveRecord::Migration
  def change
    remove_column :goals, :quarter, :string
  end
end
