class TasksController < ApplicationController
  before_action :task, only: [:update, :destroy]

  def create
    service = CreateTaskService.new(task_params)
    if service.perform
      render json: service.task, status: :created
    else
      render json: service.task.errors, status: :unprocessable_entity
    end
  end

  def update
    service = UpdateTaskService.new(@task, task_params)
    if service.perform
      render json: service.task, status: :accepted
    else
      render json: service.task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    service = DestroyTaskService.new(@task)
    if service.perform
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  def reorder_position
    service = ReorderTasksService.new(params[:tasks])
    if service.perform
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  protected

  def task
    @task = current_project.tasks.find(params[:id])
  end

  def current_project
    current_user.projects.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:name, :status, :due_date)
      .merge(project: current_project)
  end
end
