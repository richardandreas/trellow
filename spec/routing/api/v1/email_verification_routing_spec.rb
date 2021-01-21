# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::EmailVerificationsController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/api/v1/email_verifications/aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa')
        .to route_to('api/v1/email_verifications#show', id: 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa')
    end
  end
end
