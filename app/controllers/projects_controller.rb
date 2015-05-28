class ProjectsController < ApplicationController

  before_action :project, only: [:update, :destroy]

  def index
    render json: current_user.projects
  end

  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
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
    params.permit(:name)
  end
end
