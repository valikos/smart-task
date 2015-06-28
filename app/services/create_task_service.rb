class CreateTaskService < ServiceBase
  set_model Task

  attr_reader :task

  def initialize(params = {})
    @params = params
    @task = model.new @params
  end

  def perform
    @task.save
  end
end
