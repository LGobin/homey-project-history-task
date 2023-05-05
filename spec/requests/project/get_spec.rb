# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectsController, type: :request do
  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:project) { create(:project) }

    context 'when project exists and user is signed in' do
      before do
        sign_in user
        get project_history_path(project.id)
      end

      it 'returns a success response' do
        expect(response).to be_successful
      end

      it 'assigns @project' do
        expect(assigns(:project)).to eq(project)
      end

      it 'assigns @history_data' do
        expect(assigns(:history_data)).to be_a(Array)
      end
    end

    context "when project exists and user isn't signed in" do
      before { get project_history_path(project.id) }

      it 'returns a found response' do
        expect(response).to have_http_status(:found)
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
