require 'rails_helper'

RSpec.describe "Homes", type: :request do

  describe "GET /index" do
    before { get "/" }
    it { expect(response).to have_http_status(:success) }
  end

end
