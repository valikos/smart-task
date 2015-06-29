class CommentsController < ApplicationController
  before_action :comment, only: :destroy

  def create
    service = CreateCommentService.new(comment_params)

    if service.perform
      render json: service.comment, status: :created
    else
      render json: service.comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    service = DestroyCommentService.new(@comment)

    if service.perform
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  private

  def comment
    @comment ||= current_task.comments.find params[:id]
  end

  def current_task
    @current_task ||= current_user.tasks.find(params[:task_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
      .merge(task: current_task)
  end
end
