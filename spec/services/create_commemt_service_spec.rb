require 'rails_helper'

describe CreateCommentService do
  let(:service) {
    CreateCommentService.new params
  }
  let(:task) { FactoryGirl.create :task }
  let(:params) {
    FactoryGirl.attributes_for(:comment, task_id: task.id)
  }

  describe '.new' do
    it 'respons to new comment' do
      expect(service.comment).to be_a_instance_of Comment
    end
  end

  describe '#perform' do
    context 'when positive' do
      it 'returns with positive status' do
        expect(service.perform).to be true
      end

      it 'creates new comment' do
        service.perform
        expect(Comment.count).to be 1
      end
    end

    context 'when failure' do
      let(:params) { Hash.new }

      it 'returns with negative status' do
        expect(service.perform).to be false
      end

      it 'respons to comment errors' do
        service.perform
        expect(service.comment.errors).to be_a ActiveModel::Errors
      end
    end
  end
end
