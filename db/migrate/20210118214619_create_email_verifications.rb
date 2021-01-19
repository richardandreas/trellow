# frozen_string_literal: true

# CreateEmailVerifications
class CreateEmailVerifications < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto'

    create_table :email_verifications, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true
      # TODO: Add new_email column for user email update

      t.datetime :created_at
    end
  end
end
