class ChangeSenderToSenderId < ActiveRecord::Migration
  def change
    rename_column :feedbacks, :sender, :sender_id
  end
end
