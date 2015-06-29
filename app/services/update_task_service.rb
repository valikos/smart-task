class UpdateTaskService < ServiceBase
  attr_reader :task

  def initialize(task, params = {})
    @task = task
    @params = params
  end

  def perform
    @task.update@params
  end
end
