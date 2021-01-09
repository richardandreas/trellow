# frozen_string_literal: true

module Api
  module V1
    # Controller responsible for managing users projects
    class ProjectsController < ApiController
      before_action :set_project, only: %i[show edit update destroy]

      # GET /api/v1/projects.json
      def index
        @projects = current_user.projects

        render json: @projects, except: :password_digest, status: :ok
      end

      # GET /api/v1/projects/1.json
      def show
        render json: @project, except: :password_digest, status: :ok
      end

      # POST /api/v1/projects.json
      def create
        @project = Project.new(project_params)

        if @project.save
          render json: @project, except: :password_digest, status: :created
        else
          render json: { errors: @project.errors }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/projects/1.json
      def update
        if @project.update(project_params)
          render json: @project, except: :password_digest, status: :ok
        else
          render json: { errors: @project.errors }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/projects/1.json
      def destroy
        @project.destroy
        head :ok
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_project
        @project = Project.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def project_params
        params.permit(:user_id, :name, :description)
      end
    end
  end
end
