class AddStuffToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :team_size, :integer
    add_column :teams, :creator_id, :uuid
  end
end
