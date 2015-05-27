require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Relations' do
    it { expect(subject).to belong_to(:task) }
  end
end
