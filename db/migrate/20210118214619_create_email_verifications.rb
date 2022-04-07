# frozen_string_literal: true

# CreateEmailVerifications
class CreateEmailVerifications < ActiveRecord::Migration[6.1]
  def change
    create_table :email_verifications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :uuid, null: false, limit: 64, index: true
      t.string :new_email, limit: 90

      t.datetime :created_at
    end
  end
end
