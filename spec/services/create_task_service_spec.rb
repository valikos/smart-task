require 'rails_helper'

describe CreateTaskService do
  let(:service) { CreateTaskService.new params }
  describe '#model' do
    let(:params) { Hash.new }
    it 'returns Task model' do
      expect(service.model).to be Task
    end
  end

  describe '#perform' do
    let(:project) { FactoryGirl.create :project }
    let(:params) {
      { project_id: project.id, name: 'name', status: true, due_date: Time.now }
    }

    context 'when success' do
      it 'returns positive status' do
        expect(service.perform).to be true
      end

      it 'creates new task' do
        service.perform
        expect(service.task).to be_an_instance_of(Task)
      end
    end

    context 'when failure' do
      let(:params) { Hash.new }

      it 'returns negative status' do
        expect(service.perform).to be false
      end

      it 'responds for task errors' do
        service.perform
        expect(service.task.errors).to be_a ActiveModel::Errors
      end
    end
  end
end
