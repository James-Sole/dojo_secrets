class SecretsController < ApplicationController
  def index
    @secrets ||= Secret.eager_load(:user, :likes).all
    render layout:"login_reg"
  end
  def create
		@secret ||= Secret.create(content:params[:content],user_id:session[:user_id])
		if @secret.valid?
			return redirect_to user_path(session[:user_id])
		end

		flash[:alert] = @secret.errors.full_messages
		# p @secret.errors.full_messages
		return redirect_to user_path(session[:user_id])
	end

	def destroy
		@this_secret = Secret.find_by(id: params[:id])
		if session[:user_id] == @this_secret.user.id
			@this_secret.destroy
			return redirect_to user_path(session[:user_id])
		else
			flash[:alert] = ["That is not your secret to destroy."]
			return redirect_to secrets_path
		end
	end

end
