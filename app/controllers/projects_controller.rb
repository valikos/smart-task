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
    service = UpdateProjectService.new(@project, project_params)
    if service.perform
      render json: service.project, status: :accepted
    else
      render json: service.project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    service = DestroyProjectService.new(@project)
    if service.perform
      head :no_content
    else
      head :unprocessable_entity
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
