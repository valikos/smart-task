class ProjectsController < ApplicationController

  before_action :project, only: [:update, :destroy]

  def index
    render json: current_user.projects
  end

  def create
    service = CreateProjectService.new(project_params)
    if service.perform
      render json: service.project, status: :created
    else
      render json: service.project.errors, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      render json: @project, status: :accepted
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @project.destroy
      head :no_content
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  private

  def project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params
      .require(:project)
      .permit(:name)
      .merge(user: current_user)
  end
end
