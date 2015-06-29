class DestroyCommentService < ServiceBase
  attr_reader :comment

  def initialize(comment)
    @comment = comment
  end

  def perform
    @comment.destroy
  end
end
