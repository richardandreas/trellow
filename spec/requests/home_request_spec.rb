require 'rails_helper'

RSpec.describe "/index", type: :request do

  describe "GET /index" do
    before { get "/" }
    it { expect(response).to have_http_status(:success) }
  end

end
