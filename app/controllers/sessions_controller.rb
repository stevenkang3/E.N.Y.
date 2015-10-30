class SessionsController < ApplicationController

def index
end

def create
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect_to "/users"
  else
    flash[:errors] = ["Invalid credentials"]
    redirect_to :back
end
end

def destroy
  session.delete(:user_id)
  redirect_to "/sessions/new"
end
end
