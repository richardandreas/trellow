# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/projects/1/sprints', type: :request do
  let(:project)            { create(:project) }
  let(:valid_attributes)   { { **attributes_for(:sprint), project_id: project.id } }
  let(:invalid_attributes) { { **attributes_for(:sprint, :with_invalid_start_date), project_id: project.id } }

  before { skip_token_auth }

  describe 'GET /index' do
    it 'renders a successful response' do
      Sprint.create! valid_attributes
      get api_v1_project_sprints_url(project), as: :json
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      sprint = Sprint.create! valid_attributes
      get api_v1_project_sprint_url(project, sprint), as: :json
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Sprint' do
        expect do
          post api_v1_project_sprints_url(project), params: valid_attributes, as: :json
        end.to change(Sprint, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Sprint' do
        expect do
          post api_v1_project_sprints_url(project), params: invalid_attributes, as: :json
        end.to change(Sprint, :count).by(0)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { attributes_for(:sprint) }

      it 'updates the requested sprint' do
        sprint = Sprint.create! valid_attributes
        patch api_v1_project_sprint_url(project, sprint), params: new_attributes, as: :json
        sprint.reload
        expect(sprint.start_date).to eq(new_attributes[:start_date])
        expect(sprint.due_date).to eq(new_attributes[:due_date])
      end
    end

    context 'with invalid parameters' do
      it 'renders a successful response (i.e. to display the "edit" template)' do
        sprint = Sprint.create! valid_attributes
        patch api_v1_project_sprint_url(project, sprint), params: invalid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested sprint' do
      sprint = Sprint.create! valid_attributes
      expect do
        delete api_v1_project_sprint_url(project, sprint), as: :json
      end.to change(Sprint, :count).by(-1)
    end
  end
end
