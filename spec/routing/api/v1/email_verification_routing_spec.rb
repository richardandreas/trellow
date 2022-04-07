# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::EmailVerificationsController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/api/v1/email_verifications/uuid').to route_to('api/v1/email_verifications#show', uuid: 'uuid')
    end
  end
end
