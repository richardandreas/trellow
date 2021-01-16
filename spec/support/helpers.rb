# frozen_string_literal: true

# Module for helper methods for tests
module Helpers
  # Skip JWT token authentication
  def headers_for(user)
    { 'access-token': JwtService.encode({ user_id: user ? user.id : create(:user),
                                          expiration: 30.minutes.from_now,
                                          deadline: 8.hours.from_now }) }
  end

  # Skip JWT token authentication
  def skip_token_auth
    allow_any_instance_of(Api::ApiController).to receive(:authenticate).and_return(true)
  end
end
