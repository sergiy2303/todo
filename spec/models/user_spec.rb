 require 'rails_helper'
RSpec.describe User, type: :model do
  describe '#completed_works?' do
    let(:user) { create(:user) }
    it 'should return true if user has completed works' do
      create(:completed_work, user: user)

      expect(user.completed_works?).to be_truthy
    end

    it 'should return false if user does not have completed works' do
      create(:work, user: user)

      expect(user.completed_works?).to be_falsey
    end
  end
end
