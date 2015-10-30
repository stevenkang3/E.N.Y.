class UsersController < ApplicationController
  # before_action :require_login, except: [:new, :create]
  # before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

  def new
    @states = ["CA", "AL", "AK", "AZ", "AR"]
  end
  def animate
  end
  def index
    @user = User.find(session[:user_id])
    @users = User.all
    @allevents = Event.order('date ASC')
    @events = Event.where('date >= ?', Date.today).order(:date)
    @states = ["CA", "AL", "AK", "AZ", "AR"]
    @county = ["Los Angeles", "SF Valley", "South LA", "West LA", "East LA", "South Bay", "San Gabriel Valley"]
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to "/users"
    else
      flash[:errors] = user.errors.full_messages
      redirect_to "/users/new"
      end
    end



    def edit
      @user = User.find(session[:user_id])
      @states = ["CA", "AL", "AK", "AZ", "AR"]
    end

    def update
        user = User.find(session[:user_id])
        user.update(user_params)
        flash[:errors] = ["New info successfully updated"]
        redirect_to "/users/edit"
      end

      def show
        current = Event.where('date >= ?', Date.today).order(:date)
        past = Event.where('date < ?', Date.today).order(:date)
        @events = current.all.where(user_id: params[:id])
        @past = past.all.where(user_id: params[:id])
        @user = User.find(params[:id])
        @join = Join.all.where(user_id:params[:id])
        @users = User.all
      end

      def past
          past = Event.where('date < ?', Date.today).order(:date)
          @past = past.all.where(user_id: params[:id])
          @user = User.find(params[:id])
          @join = Join.all.where(user_id:params[:id])
          @users = User.all
      end
  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :location, :state, :image, :password, :password_confirmation)
    end
  end
