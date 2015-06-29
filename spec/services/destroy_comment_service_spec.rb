require 'rails_helper'

describe DestroyCommentService do
  let(:comment) {
    FactoryGirl.create :comment
  }
  let(:service) {
    DestroyCommentService.new comment
  }

  describe '.new' do
    it 'respons to comment' do
      expect(service.comment).to be comment
    end
  end

  describe '#perform' do

    context 'when success' do
      it 'destroy the comment' do
        service.perform
        expect(Comment.count).to be 0
      end

      it 'returns deleted comment' do
        expect(service.perform).to be comment
      end
    end
  end
end
