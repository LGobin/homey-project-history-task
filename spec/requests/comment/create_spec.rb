# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  describe 'POST #create' do
    context 'when user is not signed in' do
      it 'redirects to the sign-in page' do
        post comments_path(format: :js)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user is signed in' do
      let(:user) { create(:user) }
      let(:project) { create(:project) }
      let(:valid_attributes) { { comment: { content: 'Test comment', project_id: project.id } } }

      before { sign_in(user) }

      context 'with valid attributes' do
        it 'creates a new comment and renders js to reload page' do
          expect {
            post comments_path(format: :js), params: valid_attributes
          }.to change(Comment, :count).by(1)

          expect(response.content_type).to eq('text/javascript; charset=utf-8')
          expect(response.body).to include('window.top.location.reload(true);')
        end
      end

      context 'with invalid attributes' do
        let(:invalid_attributes) { { comment: { content: '', project_id: project.id } } }

        it 'does not create a new comment and renders js to show errors' do
          expect {
            post comments_path(format: :js), params: invalid_attributes
          }.not_to change(Comment, :count)

          expect(response.content_type).to eq('text/javascript; charset=utf-8')
        end
      end
    end
  end
end
