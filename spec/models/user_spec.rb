require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_user)              { build(:user) }
  let(:with_invalid_username)   { build(:user, :with_invalid_username) }
  let(:with_invalid_email)      { build(:user, :with_invalid_email) }

  describe 'valid user' do
    it { expect(valid_user).to be_valid }
  end

  describe 'presence validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
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
  end

  describe 'auto formatting' do
    subject do
      user = described_class.new(**valid_user.attributes, username: '  with  too  many  spaces  ')
      user.validate
      user
    end

    it { expect(subject.username).to eq('with too many spaces') }
  end
end
