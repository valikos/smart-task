require 'rails_helper'

describe UpdateProjectService do
  describe '.initialize' do
    context 'when project passed' do
      let(:project) { double('project') }
      let(:params) { Hash.new }

      it 'creates instance of subject' do
        expect(UpdateProjectService.new(project))
      end
    end

    context 'when missing project' do
      it 'raises exception' do
        expect { UpdateProjectService.new }.to raise_error ArgumentError
      end
    end
  end

  describe '#model' do
    subject {
      UpdateProjectService.new double('project')
    }

    it 'returns Project model' do
      expect(subject.model).to be Project
    end
  end

  describe '#perform' do
    let(:project) {
      FactoryGirl.create :project
    }
    let(:params) {
      { name: 'test name',
        user_id: project.user.id }
    }

    subject {
      UpdateProjectService.new(project, params)
    }

    context 'when success' do
      let(:params) {
        { name: 'test name',
          user_id: project.user.id }
      }

      it 'updates the project' do
        subject.perform
      end

      it 'returns positive status' do
        expect(subject.perform).to be true
      end
    end

    context 'when failure' do
      let(:params) {
        { name: '' }
      }

      it 'returns errors' do
        subject.perform
        expect(subject.project.errors).to be_a ActiveModel::Errors
      end

      it 'returns negative status' do
        expect(subject.perform).to be false
      end
    end
  end
end
