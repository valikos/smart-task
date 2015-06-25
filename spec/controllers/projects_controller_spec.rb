require 'controller_helper'

describe ProjectsController, type: :controller do
  let(:service) {
    double(
      perform: status,
      project: double(errors: 'fake')
    )
  }

  describe '#create' do
    let(:params) {
      { project: { name: 'Fake' } }
    }

    before do
      allow(CreateProjectService).to receive(:new).and_return(service)

      sign_in FactoryGirl.create :user

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
    let(:project) {
      FactoryGirl.create :project
    }

    let(:params) {
      {
        project: { name: 'update test' },
        id: project.id
      }
    }

    before do
      allow(UpdateProjectService).to receive(:new).and_return(service)

      sign_in project.user

      get :update, params
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
    let(:project) {
      FactoryGirl.create :project
    }

    let(:params) {
      { id: project.id }
    }

    before do
      allow(DestroyProjectService).to receive(:new).and_return(service)

      sign_in project.user

      get :destroy, params
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
