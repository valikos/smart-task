class ReorderTasksService < ServiceBase
  set_model Task

  attr_reader :order

  def initialize(order)
    @order = order
  end

  def perform
    order.each_with_index do |id, index|
      model.update(id, position: index + 1)
    end
  end
end
