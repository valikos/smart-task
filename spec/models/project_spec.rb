require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'Relations' do
    it { expect(subject).to belong_to(:user) }
    it { expect(subject).to have_many(:tasks) }
  end

  describe 'Validations' do
    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_length_of(:name).is_at_most(160) }
  end
end
