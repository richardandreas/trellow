# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_user)             { build(:user) }
  let(:with_invalid_username)  { build(:user, :with_invalid_username) }
  let(:with_invalid_email)     { build(:user, :with_invalid_email) }
  let(:with_unequal_passwords) { build(:user, :with_unequal_passwords) }

  describe 'valid user' do
    it { expect(valid_user).to be_valid }
  end

  describe 'presence validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe 'uniqueness validations' do
    it { expect(valid_user).to validate_uniqueness_of(:username) }
  end

  describe 'length validations' do
    it { is_expected.to validate_length_of(:username).is_at_most(45) }
    it { is_expected.to validate_length_of(:username).is_at_least(6) }
    it { is_expected.to validate_length_of(:email).is_at_most(90) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
    it { is_expected.to validate_length_of(:password).is_at_most(72) }
  end

  describe 'other validations' do
    it { expect(with_invalid_username).to have(1).errors_on(:username) }
    it { expect(with_invalid_email).to have(1).errors_on(:email) }
    it { expect(with_unequal_passwords).to have(1).errors_on(:password_confirmation) }
  end

  describe 'auto formatting' do
    it 'auto trims and splices username on validate' do
      user = described_class.new(**attributes_for(:user), username: '  with  too  many  spaces  ')
      user.validate
      expect(user.username).to eq('with too many spaces')
    end

    it 'auto trims emails on validate' do
      user = described_class.new(**attributes_for(:user), username: '  email@email.com  ')
      user.validate
      expect(user.username).to eq('email@email.com')
    end
  end
end
