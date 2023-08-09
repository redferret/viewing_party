require 'rails_helper'

RSpec.describe UserQuery do
  describe '.user_with_email' do
    subject { described_class.user_with_email(email: email) }

    context 'when the user exists' do
      let!(:user) { create(:user, email: email) }
      let(:email) { 'fake@email.com' }

      it 'returns the user' do
        expect(subject).to eq(user)
      end
    end

    context 'when the user does not exist' do
      let(:email) { 'fake@email.com' }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end
end
