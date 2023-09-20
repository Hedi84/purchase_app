require 'rails_helper'

RSpec.describe "Api::V1::ItemOptions", type: :request do
  describe "GET /api/v1/item_options" do
    it "works! (now write some real specs)" do
      get api_v1_item_options_path
      expect(response).to have_http_status(200)
    end
  end
end
