require 'rails_helper'

describe DestroyTaskService do
  describe '.initialize' do
    let(:task) { double(:task) }

    context 'when task passed' do
      it 'creates instance of subject' do
        expect(DestroyTaskService.new(task))
      end
    end

    context 'when missing task' do
      it 'raises exception' do
        expect { DestroyTaskService.new }.to raise_error ArgumentError
      end
    end
  end

  describe '#perform' do
    let(:task) {
      FactoryGirl.create :task
    }

    subject {
      DestroyTaskService.new(task)
    }

    context 'when success' do
      it 'destroy the task' do
        subject.perform
      end

      it 'returns deleted task' do
        expect(subject.perform).to be task
      end
    end
  end
end
