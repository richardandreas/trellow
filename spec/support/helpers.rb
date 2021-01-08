# frozen_string_literal: true

# Module for helper methods for tests
module Helpers
  # Skip JWT token authentication
  def skip_token_auth
    allow_any_instance_of(Api::ApiController).to receive(:authenticate).and_return(true)
  end
end
