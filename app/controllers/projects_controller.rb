class ProjectsController < ApplicationController

  before_action :project!, only: [:update, :destroy]

  def index
    @projects = Project.all

    render json: @projects
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      render json: @project, status: 204
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    if @project.update!(project_params)
      head :no_content
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

  def project!
    @project = Project.find(params[:id])
  end

  def project_params
    params.permit(:name)
  end
end
