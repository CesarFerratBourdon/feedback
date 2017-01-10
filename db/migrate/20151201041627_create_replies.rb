class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies, id: :uuid do |t|
      t.text :content
      t.uuid :feedback_id, index: true, foreign_key: true
      t.uuid :user_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
