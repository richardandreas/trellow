# frozen_string_literal: true

# Sprint
#
# Attributes
#   project:    Project
#   start_date: Date
#   due_date:   Date
#
class Sprint < ApplicationRecord
  belongs_to :project

  validates :start_date,
            presence: true,
            range: { on_or_after: ->(record) { record.start_date_was || Date.today } }

  validates :due_date,
            presence: true,
            range: { on_or_after: ->(record) { record.start_date } }
end
