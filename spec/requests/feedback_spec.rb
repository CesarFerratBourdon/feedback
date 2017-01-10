require 'rails_helper'
require 'shared_contexts'

describe 'Feedback' do
  include_context 'api request authentication helper methods'
  include_context 'api request global before and after hooks'

  before :all do
    @manager = FactoryGirl.create :manager
    @employee = FactoryGirl.create :employee, manager_id: @manager.id
  end

  describe 'GET /users/:user_id/feedbacks' do
    it 'lists feedbacks' do
      FactoryGirl.create :feedback, user_id: @employee.id, sender_id: @manager.id
      request_headers = {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }
      sign_in @employee
      get "/users/#{@employee.id}/feedbacks", nil, request_headers
      expect(response.status).to eq 200
      parsed = JSON.parse(response.body)
      expect(parsed.count).to eq 1
      expect(parsed[0]['comment']).to eq 'You are cool'
    end
  end

  describe 'POST /users/:user_id/feedbacks' do
    it 'creates feedback' do
      goal = FactoryGirl.create :goal, user_id: @employee.id, creator_id: @manager.id
      feedback_params = {
        feedback: {
          comment: 'You are cool.',
          rating: 4,
          goal_id: goal.id,
          icon: 'smile-o'
        }
      }
      request_headers = {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }
      sign_in @manager
      post "/users/#{@employee.id}/feedbacks", feedback_params.to_json, request_headers
      expect(response.status).to eq 201
      parsed = JSON.parse(response.body)
      expect(parsed['comment']).to eq 'You are cool.'
    end
  end
end
