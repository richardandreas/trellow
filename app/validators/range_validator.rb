# frozen_string_literal: true

# Validates if a value is the same or after another given value
class RangeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    min_value = options.fetch(:on_or_after).call(record)

    return if value.blank? || min_value.blank? || min_value <= value

    record.errors.add(attribute.to_sym, :not_equal_or_after, value: I18n.l(min_value))
  end
end
