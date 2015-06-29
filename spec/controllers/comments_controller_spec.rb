require 'controller_helper'

describe CommentsController, type: :controller do
  let(:comment) { FactoryGirl.create :comment }
  let(:service) {
    double(
      perform: status,
      comment: double(errors: 'errors')
    )
  }

  describe '#create' do
    let(:task) { FactoryGirl.create :task }
    let(:params) {
      {
        task_id: task.id,
        project_id: task.project.id,
        comment: { content: 'comment' }
      }
    }

    before do
      allow(CreateCommentService).to receive(:new).and_return(service)

      sign_in task.project.user

      post :create, params
    end

    context 'when success' do
      let(:status) { true }

      it { should respond_with(201) }
    end

    context 'when failure' do
      let(:status) { false }

      it { should respond_with(422) }
    end
  end

  describe '#destroy' do
    let(:params) {
      { id: comment.id,
        task_id: comment.task.id,
        project_id: comment.task.project.id }
    }

    before do
      allow(DestroyCommentService).to receive(:new).and_return(service)

      sign_in comment.task.project.user

      post :destroy, params
    end

    context 'when success' do
      let(:status) { true }

      it { should respond_with(204) }
    end

    context 'when failure' do
      let(:status) { false }

      it { should respond_with(422) }
    end
  end
end
