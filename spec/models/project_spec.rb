require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'Attributes' do
    it { expect(subject).to validate_presence_of :name }
  end

  describe 'Validations' do
    it { expect(subject).to validate_length_of(:name).is_at_most(160) }
  end
end
