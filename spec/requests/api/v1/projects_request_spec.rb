# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/projects', type: :request do
  let(:valid_attributes)   { attributes_for(:project) }
  let(:invalid_attributes) { attributes_for(:project, :with_invalid_name) }

  before { skip_token_auth }

  describe 'GET /index' do
    it 'renders a successful response' do
      project = Project.create! valid_attributes
      allow_any_instance_of(Api::ApiController).to receive(:current_user).and_return(project.user)
      get api_v1_projects_url, as: :json
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      project = Project.create! valid_attributes
      get api_v1_project_url(project), as: :json
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Project' do
        expect do
          post api_v1_projects_url, params: valid_attributes, as: :json
        end.to change(Project, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Project' do
        expect do
          post api_v1_projects_url, params: invalid_attributes, as: :json
        end.to change(Project, :count).by(0)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { valid_attributes }

      it 'updates the requested project' do
        project = Project.create! valid_attributes
        patch api_v1_project_url(project), params: new_attributes, as: :json
        project.reload
        expect(project.name).to eq(new_attributes[:name])
        expect(project.description).to eq(new_attributes[:description])
      end
    end

    context 'with invalid parameters' do
      it 'renders a successful response (i.e. to display the "edit" template)' do
        project = Project.create! valid_attributes
        patch api_v1_project_url(project), params: invalid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested project' do
      project = Project.create! valid_attributes
      expect do
        delete api_v1_project_url(project), as: :json
      end.to change(Project, :count).by(-1)
    end
  end
end
