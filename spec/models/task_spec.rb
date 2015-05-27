require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Relations' do
    it { expect(subject).to belong_to(:project) }
    it { expect(subject).to have_many(:comments) }
    it { expect(subject).to have_many(:attachments) }
  end

  describe 'Validations' do
    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_length_of(:name).is_at_most(160) }
  end
end
