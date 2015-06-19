class CreateProjectService < ServiceBase

  set_model ::Project

  attr_reader :project

  def initialize(params = {})
    @project = model.new(params)
  end

  def perform
    @project.save
  end
end
