# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JwtService do
  let(:hash) { { "#{Faker::Lorem.word}": Faker::Lorem.word } }

  it { expect(described_class.encode(hash)).to be_a(String) }
  it { expect(described_class.decode(described_class.encode(hash))).to be_a(Hash) }
end
