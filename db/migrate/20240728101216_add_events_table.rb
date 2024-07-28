# frozen_string_literal: true

class AddEventsTable < ActiveRecord::Migration[7.1]

  def change
    create_table :events do |t|
      t.string :name, null: false, limit: 255
      t.string :iterable_event_id, limit: 36

      t.timestamps
    end

    add_index :events, :name, unique: true
    add_index :events, %i[iterable_event_id name], unique: true
  end

end
