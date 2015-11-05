class JoinsController < ApplicationController
before_action :require_login, only: [:create, :destroy]
  def create
    joined = Join.find_by(user_id: params[:user_id], event_id: params[:event_id])
    if (joined)
      redirect_to "/event/#{params[:event_id]}"
    else
      Join.create(user_id: params[:user_id], event_id: params[:event_id])
      redirect_to "/event/#{params[:event_id]}"
    end
  end

  def destroy
    joined = Join.find_by(user_id: params[:user_id], event_id: params[:event_id])
    if (joined)
    joined.destroy
      redirect_to "/event/#{params[:event_id]}"
    else
      redirect_to "/users"
    end
  end

end
