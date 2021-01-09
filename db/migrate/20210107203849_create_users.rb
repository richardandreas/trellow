# frozen_string_literal: true

# CreateUsers
class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username, null: false, limit: 45
      t.string :email, null: false, limit: 90
      t.string :password_digest, null: false

      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
