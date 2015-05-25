require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Relations' do
    it { expect(subject).to have_many :projects }
  end
end
