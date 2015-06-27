require 'controller_helper'

describe TasksController, type: :controller do
  let(:task) { FactoryGirl.create :task }
  let(:service) {
    double(
      perform: status,
      task: double(errors: 'fake')
    )
  }

  describe '#create' do
    let(:project) { FactoryGirl.create :project }

    let(:params) {
      {
        project_id: project.id,
        task: {
          name: 'Test',
          status: true,
          due_date: Time.now
        }
      }
    }

    before do
      allow(CreateTaskService).to receive(:new).and_return(service)

      sign_in project.user

      get :create, params
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

  describe '#update' do
    let(:task) { FactoryGirl.create :task }
    let(:params) {
      {
        id: task.id,
        project_id: task.project.id,
        task: {name: 'test', status: true, due_date: Time.now }
      }
    }

    before do
      allow(UpdateTaskService).to receive(:new).and_return(service)

      sign_in task.project.user

      xhr :get, :update, params
    end

    context 'when success' do
      let(:status) { true }

      it { should respond_with(202) }
    end

    context 'when failure' do
      let(:status) { false }

      it { should respond_with(422) }
    end
  end

  describe '#destroy' do
    let(:task) { FactoryGirl.create :task }
    let(:params) {
      {
        id: task.id,
        project_id: task.project.id
      }
    }

    before do
      allow(DestroyTaskService).to receive(:new).and_return(service)

      sign_in task.project.user

      xhr :post, :destroy, params
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

  describe '#reorder_position' do
    let(:params) {
      {
        project_id: task.project.id,
        tasks: [1,2,3,4]
      }
    }

    before do
      allow(ReorderTasksService).to receive(:new).and_return(service)

      sign_in task.project.user

      xhr :post, :reorder_position, params
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
