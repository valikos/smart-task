require 'rails_helper'

describe DestroyProjectService do
  describe '.initialize' do
    let(:project) { double(:project) }

    context 'when project passed' do
      it 'creates instance of subject' do
        expect(DestroyProjectService.new(project))
      end
    end

    context 'when missing project' do
      it 'raises exception' do
        expect { DestroyProjectService.new }.to raise_error ArgumentError
      end
    end
  end

  describe '#perform' do
    let(:project) {
      FactoryGirl.create :project
    }

    subject {
      DestroyProjectService.new(project)
    }

    context 'when success' do
      it 'destroy the project' do
        subject.perform
      end

      it 'returns deleted project' do
        expect(subject.perform).to be project
      end
    end
  end
end
