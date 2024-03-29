class InitSchema < ActiveRecord::Migration
  def up
    
    # These are extensions that must be enabled in order to support this database
    enable_extension "plpgsql"
    enable_extension "uuid-ossp"
    
    create_table "active_admin_comments", force: :cascade do |t|
      t.string   "namespace"
      t.text     "body"
      t.string   "resource_id",   null: false
      t.string   "resource_type", null: false
      t.integer  "author_id"
      t.string   "author_type"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
    
    create_table "admin_users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
      t.string   "email",                  default: "", null: false
      t.string   "encrypted_password",     default: "", null: false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",          default: 0,  null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.inet     "current_sign_in_ip"
      t.inet     "last_sign_in_ip"
      t.datetime "created_at",                          null: false
      t.datetime "updated_at",                          null: false
    end
    
    add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
    
    create_table "delayed_jobs", force: :cascade do |t|
      t.integer  "priority",   default: 0, null: false
      t.integer  "attempts",   default: 0, null: false
      t.text     "handler",                null: false
      t.text     "last_error"
      t.datetime "run_at"
      t.datetime "locked_at"
      t.datetime "failed_at"
      t.string   "locked_by"
      t.string   "queue"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
    
    create_table "feedbacks", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
      t.uuid     "user_id"
      t.integer  "rating"
      t.text     "comment"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.uuid     "goal_id"
      t.string   "icon"
      t.uuid     "sender"
    end
    
    add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id", using: :btree
    
    create_table "goals", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
      t.uuid     "user_id"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "quarter"
      t.text     "self_evaluation"
      t.text     "manager_evaluation"
      t.string   "state",                 default: "new"
      t.uuid     "creator"
      t.integer  "manager_eval_progress"
      t.integer  "manager_eval_rating"
      t.string   "manager_eval_icon"
    end
    
    add_index "goals", ["user_id"], name: "index_goals_on_user_id", using: :btree
    
    create_table "invites", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
      t.uuid     "user_id"
      t.string   "first_name"
      t.string   "last_name"
      t.string   "email"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "is_manager"
    end
    
    add_index "invites", ["user_id"], name: "index_invites_on_user_id", using: :btree
    
    create_table "roles", force: :cascade do |t|
      t.string   "name"
      t.integer  "resource_id"
      t.string   "resource_type"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    add_index "roles", ["name"], name: "index_roles_on_name", using: :btree
    
    create_table "teams", force: :cascade do |t|
      t.string   "domain_name"
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
      t.string   "email",                  default: "", null: false
      t.string   "encrypted_password",     default: "", null: false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",          default: 0,  null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.inet     "current_sign_in_ip"
      t.inet     "last_sign_in_ip"
      t.datetime "created_at",                          null: false
      t.datetime "updated_at",                          null: false
      t.string   "first_name"
      t.string   "last_name"
      t.string   "username"
      t.integer  "team_id"
      t.string   "confirmation_token"
      t.datetime "confirmed_at"
      t.datetime "confirmation_sent_at"
      t.string   "avatar_file_name"
      t.string   "avatar_content_type"
      t.integer  "avatar_file_size"
      t.datetime "avatar_updated_at"
      t.uuid     "manager_id"
    end
    
    add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
    add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    add_index "users", ["team_id"], name: "index_users_on_team_id", using: :btree
    
    create_table "users_roles", id: false, force: :cascade do |t|
      t.uuid    "user_id"
      t.integer "role_id"
    end
    
    add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
    
  end

  def down
    raise "Can not revert initial migration"
  end
end
