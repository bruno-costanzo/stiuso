# frozen_string_literal: true

class AddUserToProfiles < ActiveRecord::Migration[8.1]
  def change
    add_reference :profiles, :user, foreign_key: true

    reversible do |dir|
      dir.up do
        execute "UPDATE profiles SET user_id = 1 WHERE user_id IS NULL"
      end
    end

    change_column_null :profiles, :user_id, false
  end
end
