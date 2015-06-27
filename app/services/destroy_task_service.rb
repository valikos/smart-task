class DestroyTaskService < ServiceBase
  attr_reader :task

  def initialize(task)
    @task = task
  end

  def perform
    @task.destroy
  end
end
