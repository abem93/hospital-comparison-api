require 'rails_helper'

RSpec.describe "Users", type: :request do
   # show
   describe "GET /user/:id" do
    let(:user) {create(:user)}
    let(:token) { auth_token_for_user(user) }

    before do
      user
      get "/users/#{user.id}", headers: { Authorization: "Bearer #{token}"}
    end

    # response with the correct user
    it "returns a response with the correct user" do
      expect(response.body).to eq(UserBlueprint.render(user, view: :normal))
    end
  end

  # create
  describe "POST /users" do
    #valid params
    context "with valid params" do
      before do
        user_attributes = attributes_for(:user)
        post "/users", params: user_attributes
      end

      #returns a successful response
      it "returns a success response" do
        expect(response).to be_successful
      end

      it "creates a new user" do
        expect(User.count).to eq(1)
      end
    end
    # invalid params
    context "with invalid params" do
      before do
        user_attributes = attributes_for(:user, email: nil)
        post "/users", params: user_attributes
      end

      it "returns a response with errors" do
        expect(response.status).to eq(422)
      end
    end
  end

  # update
  describe "PUT /users/:id" do
    #valid params
    context "with valid params" do
      let(:user) {create(:user)}
      let(:token) { auth_token_for_user(user) }

      before do
        user_attributes = {zipcode: "65444"}
        put "/users/#{user.id}", params: user_attributes, headers: { Authorization: "Bearer #{token}"}
      end

      it "updates a user" do
        user.reload
        expect(user.zipcode).to eq("65444")
      end

      it "returns a success response" do
        expect(response).to be_successful
      end
    end

    context "with invalid params" do
      let!(:user) { create(:user) }
      let(:token) { auth_token_for_user(user) }
      
      before do
        user
        user_attributes = {email: nil}
        put "/users/#{user.id}", params: user_attributes, headers: { Authorization: "Bearer #{token}"}
      end

      it "returns a response with errors" do
        expect(response.status).to eq(422)
        
      end
    end
  end
  # destroy
  describe "DELETE /users/:id" do
    let(:user) {create(:user)}
    let(:token) { auth_token_for_user(user) }

    before do
      delete "/users/#{user.id}", headers: { Authorization: "Bearer #{token}"}
    end

    it "deletes a user" do
      expect(User.count).to eq(0)
    end
    it "returns a success response" do
      expect(response).to be_successful
    end
  end
end

