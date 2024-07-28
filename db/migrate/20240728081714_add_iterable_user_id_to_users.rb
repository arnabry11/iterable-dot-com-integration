# frozen_string_literal: true

class AddIterableUserIdToUsers < ActiveRecord::Migration[7.1]

  def change
    add_column :users, :iterable_user_id, :string, limit: 36

    add_index :users, :iterable_user_id, unique: true
  end

end
