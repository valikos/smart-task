class UpdateProjectService < ServiceBase
  attr_reader :project

  def initialize(project, params = {})
    @project = project
    @params = params
  end

  def perform
    @project.update(@params)
  end
end
