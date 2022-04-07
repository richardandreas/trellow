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
  has_one :user, through: :project

  validates :start_date,
            range: { on_or_after: ->(_record) { Date.today } }

  validates :due_date,
            range: { on_or_after: ->(record) { record.start_date } }
end
