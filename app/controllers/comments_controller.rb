class CommentsController < ApplicationController
  def create
    @comment = current_task.comments.new(comment_params)
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
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
