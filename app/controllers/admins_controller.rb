class AdminsController < ApplicationController
 # before_action :require_login, except: [:new, :create, :]
  def index
    @users = User.all
    end

    def create

      admin = Admin.new(admin_params)
        if ("#{admin_params[:key]}" == '3ny#ADMIN')
          if admin.save
            session[:user_id] = admin.id
            redirect_to "/admin"
          else
            flash[:errors] = admin.errors.full_messages
            redirect_to "/admin/new"
          end
        else
          flash[:errors] = ["Invalid Key"]
          redirect_to "/admin/new"
        end
      end

      def events 
        @events = Event.all.where(user_id: params[:id])
      end


  def new
  end

  def login
  end

  def main
      admin = Admin.find_by(email: params[:email])
      if admin && admin.authenticate(params[:password])
        session[:user_id] = admin.id
        redirect_to "/admin"
      else
        flash[:errors] = ["Invalid credentials"]
        redirect_to :back
    end
    end




  private
    def admin_params
      params.require(:admin).permit(:first_name, :last_name, :email, :key, :image, :password, :password_confirmation)
    end
  end
