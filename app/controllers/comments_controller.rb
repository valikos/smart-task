class CommentsController < ApplicationController
  def create
    if @comment = current_task.comments.create(comment_params)
      render json: @comment, status: :created
    end
  end

  def destroy
    Comment.destroy params[:id]
    head :no_content
  end

  private

  def current_task
    current_user.tasks.find(params[:task_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
