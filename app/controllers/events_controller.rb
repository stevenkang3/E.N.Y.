class EventsController < ApplicationController

  def create
  event = Event.new(name: event_params[:name], date: event_params[:date], address: event_params[:address], state: event_params[:state],
                        price: event_params[:price], start: event_params[:start], end: event_params[:end], user_id: params[:user_id],
                        capacity: event_params[:capacity], category: event_params[:category], description: event_params[:description], county: event_params[:county], image: event_params[:image])
  if event.save
    redirect_to "/users"
  else
    flash[:errors] = user.errors.full_messages
    redirect_to "/users"
    end
  end

  def edit
    @event = Event.find(params[:id])
    @categories = ["Outdoors", "Meetup", "Sports", "Games", "Food", "Tours", "Contest", "Other"];
    @counties = ["Los Angeles", "SF Valley", "Westside Cities", "South Bay", "San Gabriel Valley", "Santa Clarita"];
  end

  def update
    event = Event.find(params[:id])
    if event
      event.update(name: event_params[:name], date: event_params[:date], address: event_params[:address], state: event_params[:state],
                            price: event_params[:price], start: event_params[:start], end: event_params[:end], user_id: params[:user_id],
                            capacity: event_params[:capacity], category: event_params[:category], description: event_params[:description], county: event_params[:county], image: event_params[:image])
      flash[:errors] = ["Event successfully updated"]
      redirect_to "/events/#{params[:id]}"
    else
      redirect_to"/users"
    end
  end

  def show
    @event = Event.find(params[:id])
    @joins = @event.joins
    @user = @event.user
    @comments = Comment.all
  end

  def state
    @user = User.find(session[:user_id])
    @events = Event.all.order(:state)
    @states = ["CA", "AL", "AK", "AZ", "AR"]
    redirect_to "/users"
  end
  def date
    @user = User.find(session[:user_id])
    @events = Event.all.order(date: :desc)
    @states = ["CA", "AL", "AK", "AZ", "AR"]
    redirect_to "/users"
  end

  def destroy
   event = Event.find(params[:id])
   event.destroy if event.user == current_user
   redirect_to "/users"
  end

  def new
      @categories = ["Outdoors", "Meetup", "Sports", "Games", "Food", "Tours", "Contest", "Other"];
      @counties = ["Los Angeles", "SF Valley", "Westside Cities", "South Bay", "San Gabriel Valley", "Santa Clarita"];
  end

  def map
      @event = Event.find(params[:id])
  end

  def back
    # redirect_to "/users"
    redirect_to "/events/#{params[:id]}"
  end

  def past
    @user = User.find(session[:user_id])
    @users = User.all
    @events = Event.where('date < ?', Date.today).order(:date)
    @county = ["Los Angeles", "SF Valley", "South LA", "West LA", "East LA", "South Bay", "San Gabriel Valley"]
  end

  def tables
    @user = User.find(session[:user_id])
    @users = User.all
    @pasts = Event.where('date < ?', Date.today).order(:date)
    @events = Event.where('date >= ?', Date.today).order(:date)
  end

  private
  def event_params
    params.require(:event).permit(:name, :date, :address, :user_id, :state, :price, :start, :end, :capacity, :category, :description, :county, :category, :image)
  end
end
