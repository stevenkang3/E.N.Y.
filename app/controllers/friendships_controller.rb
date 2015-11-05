class FriendshipsController < ApplicationController

  def index
      @users = User.all.where.not(id: current_user.friendships.pluck(:friend_id)).where.not(id: Friendship.all.where(friend_id: current_user.id).pluck(:user_id)).where.not(id: current_user.id)
      @connections = User.all
      @pending = Array.new
      @connections.each do |user|
      user.friendships.each do |u|
      if u.user_id == current_user.id && u.status == "false"
        @pending.push(User.find_by(id: u.friend_id));
      end
    end
  end
  end

  def create
  connect = Friendship.create(user_id: current_user.id, friend_id: params[:id], status:'false')
    if connect
      redirect_to '/friendships'
    end
  end

  def update
    friend1 = Friendship.find_by(user_id: params[:id], friend_id: session[:user_id], status:'false')
    Friendship.create(user_id: session[:user_id], friend_id: params[:id], status:'true')
    friend1.update(user_id: params[:id], friend_id: session[:user_id], status:'true')
    redirect_to '/friendships/all'
  end

  def destroy
    friend1 = Friendship.find_by(user_id: params[:id], friend_id: session[:user_id], status:'false')
    friend1.destroy
    redirect_to '/friendships/all'
  end

  def all
    @connections = User.all
  end

end
