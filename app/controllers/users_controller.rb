class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:create]

	def index
		@users = User.all
		render json: @users
	end

	def create
		@user = User.new(user_params)
		if @user.save
			active_admin_email = AdminUser.first.email
			UserMailer.approve_email(@user, active_admin_email).deliver_now
			render json: { username: @user.username, email: @user.email }, status: :created
		else
			render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
		end
	end


	def update
		@user = User.find_by(params:[:email])
		@user.status = "approve"
		if @user.update
			render json: {messages: "User Details", user: @user}
		else 
			render json: { messages: "User email not valid"}
		end
	end

	def show
		@user = User.find_by(email: params[:email])
		if @user
			render json: { username: @user.username, email: @user.email }
		end
	end

	def find_by_email
		@user = User.find_by(email: params[:email])
		if @user
			render json: { username: @user.username, email: @user.email }
		else
			render json: { error: "User not found" }, status: :not_found
		end
	end

	private


	def user_params
		params.require(:user).permit(:username, :email, :password_digest, :role_id, :status)
	end



end
