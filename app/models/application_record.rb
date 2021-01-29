# frozen_string_literal: true

# ApplicationRecord
class ApplicationRecord < ActiveRecord::Base
  NO_SPECIAL_CHAR_REGEXP = /^[a-zA-Z 0-9]*$/

  self.abstract_class = true
end
