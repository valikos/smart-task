class DestroyProjectService < ServiceBase
  attr_reader :project

  def initialize(project)
    @project = project
  end

  def perform
    project.destroy
  end
end
