# frozen_string_literal: true

# CreateProjects
class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false, limit: 45
      t.text :description, limit: 2000

      t.timestamps
    end
    add_index :projects, %i[user_id name], unique: true
  end
end
