# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectsController, type: :request do
  let!(:user) { create(:user) }
  let!(:project) { create(:project) }
  let(:action) do
    patch project_path(project), params: params, xhr: true
    project.reload
  end

  before do
    sign_in user
  end

  describe "PATCH #update" do
    let!(:params) do
      { project: { name: "New Name", description: 'New description', 
                   next_status: "In Progress" }, id: project.id }
    end

    context "with valid params" do
      it "updates the project and creates a status change" do
        expect { action }.to change { project.name }.from(project.name).to("New Name")
                         .and change { StatusChange.count }.by(1)
        expect(response).to have_http_status(:success)
      end
    end

    context "with invalid project params" do
      let(:params) do
        { project: { name: "", description: 'Project description.' }, id: project.id }
      end

      it "does not update the project or create a status change" do
        expect { action }.not_to change { project.name }
        expect { action }.not_to change { StatusChange.count }
        expect(response).to have_http_status(:success)
      end
    end
  end
end
