class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    render layout:"login_reg"
  end
  def create
    if new_user.valid?
      session[:user_id]=new_user.id
      return redirect_to secrets_path
    end
    redirect_to :back, alert: new_user.errors.full_messages
  end
  def show
    if params[:id] == current_user.id
      @my_secrets = Secret.eager_load(:user).where(user_id:session[:user_id])
      p@my_secrets
      user
      render layout:"login_reg"
    end
    return redirect_to secrets_path
  end
  def edit
    if params[:id] == current_user.id
      user
      render layout:"login_reg"
    end
    return redirect_to secrets_path
  end
  def update
    if edit_user.valid?
      return redirect_to secrets_path
    end
    redirect_to :back, alert: edit_user.errors.full_messages
  end
  private
    helper_method def user
      @user ||= User.find(params[:id])
    end
    helper_method def new_user
      @new_user ||= User.create(user_params)
    end
    helper_method def edit_user
      @new_user ||= User.update(session[:user_id],update_params)
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def update_params
      params.require(:user).permit(:name, :email)
    end
end
