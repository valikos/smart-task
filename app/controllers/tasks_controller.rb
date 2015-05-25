class TasksController < ApplicationController
  # before_action :set_current_user, :authenticate_request

  def create
    if current_project.tasks.create(task_params)
      render json: @task, status: :created
    end
  end

  def update
    @task = current_project.tasks.find(params[:id])
    if @task.update(task_params)
      render json: @task.errors, status: :accepted
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Task.destroy params[:id]
    head :no_content
  end

  def reorder_position
    params[:tasks].each_with_index do |id, index|
      Task.update(id, position: index + 1)
    end
    render nothing: true
  end

  protected

  def current_project
    current_user.projects.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:name, :status, :due_date)
  end
end
