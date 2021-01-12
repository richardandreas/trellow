# frozen_string_literal: true

module Api
  module V1
    # Controller responsible for managing project sprints
    class SprintsController < ApiController
      before_action :set_project
      before_action :set_sprint, only: %i[show update destroy]

      # GET /api/v1/sprints.json
      def index
        @sprints = @project.sprints

        render json: @sprints, except: :password_digest, status: :ok
      end

      # GET /api/v1/sprints/1.json
      def show
        render json: @sprint, except: :password_digest, status: :ok
      end

      # POST /api/v1/sprints.json
      def create
        @sprint = Sprint.new(sprint_params)

        if @sprint.save
          render json: @sprint, except: :password_digest, status: :created
        else
          render json: { errors: @sprint.errors }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/sprints/1.json
      def update
        if @sprint.update(sprint_params)
          render json: @sprint, except: :password_digest, status: :ok
        else
          render json: { errors: @sprint.errors }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/sprints/1.json
      def destroy
        @sprint.destroy
        head :ok
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_project
        @project = Project.find(params[:project_id])
      end

      def set_sprint
        @sprint = @project.sprints.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def sprint_params
        params.permit(:project_id, :start_date, :due_date)
      end
    end
  end
end
