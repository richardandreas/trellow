# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sprint, type: :model do
  let(:valid_sprint)            { build(:sprint) }
  let(:with_invalid_start_date) { build(:sprint, :with_invalid_start_date) }
  let(:with_invalid_due_date)   { build(:sprint, :with_invalid_due_date) }

  describe 'valid sprint' do
    it { expect(valid_sprint).to be_valid }
  end

  describe 'presence validations' do
    it { is_expected.to belong_to(:project) }
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:due_date) }
  end

  describe 'other validations' do
    it { expect(with_invalid_start_date).to have(1).errors_on(:start_date) }
    it { expect(with_invalid_due_date).to have(1).errors_on(:due_date) }
  end
end
