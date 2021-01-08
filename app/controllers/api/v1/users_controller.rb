module Api
  module V1
    # Controller responsible for managing application users
    class UsersController < ApiController
      before_action :set_user, only: [:show, :edit, :update, :destroy]

      # GET /users.json
      def index
        @users = User.all

        render json: @users, status: :ok
      end

      # GET /users/1.json
      def show
        render json: @user, status: :ok
      end

      # POST /users.json
      def create
        @user = User.new(user_params)

        if @user.save
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /users/1.json
      def update
        if @user.update(user_params)
          render json: @user, status: :ok
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # DELETE /users/1.json
      def destroy
        @user.destroy
        head :no_content, status: :ok
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
      end
    end
  end
end
