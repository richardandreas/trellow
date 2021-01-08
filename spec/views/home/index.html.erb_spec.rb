# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'home/index.html.erb', type: :view do
  describe 'index' do
    before { render }
    it { expect(rendered).to match(/You need to enable JavaScript to run this app./) }
  end
end
