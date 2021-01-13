# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SprintsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/projects/1/sprints').to route_to('api/v1/sprints#index', project_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/api/v1/projects/1/sprints/1').to route_to('api/v1/sprints#show', project_id: '1', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/v1/projects/1/sprints').to route_to('api/v1/sprints#create', project_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/v1/projects/1/sprints/1').to route_to('api/v1/sprints#update', project_id: '1', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/v1/projects/1/sprints/1').to route_to('api/v1/sprints#update', project_id: '1', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/api/v1/projects/1/sprints/1').to route_to('api/v1/sprints#destroy', project_id: '1', id: '1')
    end
  end
end
