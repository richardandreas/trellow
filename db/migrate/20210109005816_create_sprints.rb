# frozen_string_literal: true

# CreateSprints
class CreateSprints < ActiveRecord::Migration[6.1]
  def change
    create_table :sprints do |t|
      t.references :project, null: false, foreign_key: true
      t.date :start_date
      t.date :due_date

      t.timestamps
    end
  end
end
