# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Root', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe 'GET /' do
    it 'renders the projects index page' do
      sign_in user
      get root_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Projects')
    end

    context "when user isn't signed in" do
      before do
        get root_path
      end

      it 'returns a found response' do
        expect(response).to have_http_status(:found)
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
