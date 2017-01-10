class UnreadMigration < ActiveRecord::Migration
  def self.up
    create_table :read_marks, force: true do |t|
      t.uuid :readable_id, polymorphic: { null: false }
      t.uuid :reader_id,   polymorphic: { null: false }
      t.string :readable_type
      t.string :reader_type
      t.datetime :timestamp
    end

    add_index :read_marks, [:reader_id, :reader_type, :readable_type, :readable_id], name: 'read_marks_reader_readable_index'
  end

  def self.down
    drop_table :read_marks
  end
end
