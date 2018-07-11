class LikesController < ApplicationController

  def destroy
    error = []
    @likes= Like.find_by(user_id:params[:user_id],secret_id:params[:secrets_id])
    if @likes != nil
      @like ||= Like.find_by(user_id:params[:user_id], secret_id:params[:secrets_id]).destroy
      return redirect_to secrets_path
    end
    error << "Can like a secret once"
    return redirect_to secrets_path, alert: error
  end
  def create
    error = []
    @likes= Like.find_by(user_id:params[:user_id],secret_id:params[:secrets_id])
    if @likes == nil
      @like ||= Like.create(user_id:params[:user_id], secret_id:params[:secrets_id])
      return redirect_to secrets_path
    end
    error << "Can like a secret once"
    return redirect_to secrets_path, alert: error
  end

end
