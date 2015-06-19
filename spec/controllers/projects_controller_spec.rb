require 'controller_helper'

describe ProjectsController, type: :controller do
  describe '#create' do
    let(:params) {
      { project: { name: 'Fake' } }
    }
    let(:service) {
      double(
        perform: status,
        project: double(errors: 'fake')
      )
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
end
