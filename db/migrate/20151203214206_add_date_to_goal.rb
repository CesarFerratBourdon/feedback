class AddDateToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :date, :date
  end
end
