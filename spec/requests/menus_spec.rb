require 'rails_helper'

RSpec.describe "Menus", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/menus/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/menus/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/menus/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/menus/new"
      expect(response).to have_http_status(:success)
    end
  end

end
