# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:valid_project)     { build(:project) }
  let(:with_invalid_name) { build(:project, :with_invalid_name) }

  describe 'valid project' do
    it { expect(valid_project).to be_valid }
  end

  describe 'presence validations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'uniqueness validations' do
    it { expect(valid_project).to validate_uniqueness_of(:name).case_insensitive.scoped_to(:user_id) }
  end

  describe 'length validations' do
    it { is_expected.to validate_length_of(:name).is_at_most(45) }
    it { is_expected.to validate_length_of(:name).is_at_least(3) }
    it { is_expected.to validate_length_of(:description).is_at_most(2000) }
  end

  describe 'other validations' do
    it { expect(with_invalid_name).to have(1).errors_on(:name) }
  end

  describe 'auto formatting' do
    it 'auto trims and splices name on validate' do
      project = described_class.new(**attributes_for(:project), name: '  with  too  many  spaces  ')
      project.validate
      expect(project.name).to eq('with too many spaces')
    end

    it 'auto trims description on validate' do
      project = described_class.new(**attributes_for(:project), description: '  with  too  many  spaces  ')
      project.validate
      expect(project.description).to eq('with  too  many  spaces')
    end
  end
end
