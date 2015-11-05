class CommentsController < ApplicationController

  def create
  comment = Comment.new(content: params[:comment], event_id: params[:event_id], user_id: params[:user_id])
  if comment.save
    redirect_to "/event/#{params[:event_id]}"
  else
    flash[:errors] = ["Comment did not save"]
    redirect_to "/event/#{params[:event_id]}"
    end
  end

end
