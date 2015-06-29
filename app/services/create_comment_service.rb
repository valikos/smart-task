class CreateCommentService < ServiceBase
  set_model Comment

  attr_reader :comment

  def initialize(params = {})
    @comment = model.new(params)
  end

  def perform
    @comment.save
  end
end
