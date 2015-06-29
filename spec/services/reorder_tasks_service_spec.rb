require 'rails_helper'

describe ReorderTasksService do
  describe '#model' do
    let(:service) { ReorderTasksService.new([]) }

    it 'responds to the Task model' do
      expect(service.model).to be Task
    end
  end

  describe '#perform' do
    let(:order) {
      Task.all.map(&:id)
    }
    let(:service) {
      ReorderTasksService.new(order)
    }

    before do
      FactoryGirl.create_list(:task, 5)
    end

    it 'reorder tasks' do
      service.perform
      expect(Task.order(:position).map(&:id)).to eq order
    end
  end
end
