# frozen_string_literal: true

class AddEventsUsersJoinTable < ActiveRecord::Migration[7.1]

  def change
    create_table :events_users do |t|
      t.references :event, foreign_key: { on_delete: :cascade }, null: false, index: false
      t.references :user, foreign_key: { on_delete: :cascade }, null: false

      t.timestamps
    end

    add_index :events_users, %i[event_id user_id], unique: true
  end

end
