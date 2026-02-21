# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.text :bio
      t.boolean :active

      t.timestamps
    end
  end
end
