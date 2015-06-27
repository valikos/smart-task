require 'rails_helper'

describe UpdateTaskService do
  describe '.initialize' do
    context 'when task passed' do
      let(:task) { double('task') }
      let(:params) { Hash.new }

      it 'creates instance of subject' do
        expect(UpdateTaskService.new(task, params))
      end
    end

    context 'when missing project' do
      it 'raises exception' do
        expect { UpdateTaskService.new }.to raise_error ArgumentError
      end
    end
  end

  describe '#perform' do
    let(:task) {
      FactoryGirl.create :task
    }
    let(:params) {
      { id: task.id,
        name: 'test name',
        status: false,
        due_date: Time.now }
    }

    let(:service) {
      UpdateTaskService.new(task, params)
    }

    context 'when success' do
      it 'updates the task' do
        service.perform
      end

      it 'returns positive status' do
        expect(service.perform).to be true
      end
    end

    context 'when failure' do
      let(:params) {
        { name: '' }
      }

      it 'returns negative status' do
        expect(service.perform).to be false
      end

      it 'returns task errors' do
        service.perform
        expect(service.task.errors).to be_a ActiveModel::Errors
      end
    end
  end
end