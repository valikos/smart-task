require 'rails_helper'

describe CreateProjectService do
  describe '#model' do
    subject {
      CreateProjectService.new
    }

    it 'returns Project model' do
      expect(subject.model).to be Project
    end
  end

  describe '#perform' do
    subject {
      CreateProjectService.new(options)
    }

    context 'when success' do
      let(:options) {
        { name: 'fake', user: FactoryGirl.create(:user) }
      }

      it 'creates new project' do
        subject.perform
      end

      it 'returns positive status' do
        expect(subject.perform).to be true
      end
    end

    context 'when failure' do
      let(:options) { {} }

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
