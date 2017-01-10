require 'rails_helper'
require 'shared_contexts'

describe 'Goal' do
  include_context 'api request authentication helper methods'
  include_context 'api request global before and after hooks'

  before :all do
    @manager = FactoryGirl.create :manager
    @employee = FactoryGirl.create :employee, manager_id: @manager.id
  end

  describe 'GET /users/:user_id/goals' do
    it 'lists goals' do
      FactoryGirl.create :goal, user_id: @employee.id, creator_id: @manager.id
      request_headers = {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }
      sign_in @employee
      get "/users/#{@employee.id}/goals", nil, request_headers
      expect(response.status).to eq 200
      parsed = JSON.parse(response.body)
      expect(parsed['in_progress'].count).to eq 1
      expect(parsed['completed'].count).to eq 0
    end
  end


  describe 'POST /users/:user_id/goals' do
    it 'creates a goal and takes it through the lifecycle' do
      goal_params = {
        goal: {
          description: 'A goal'
        }
      }
      request_headers = {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }
      sign_in @employee
      post "/users/#{@employee.id}/goals", goal_params.to_json, request_headers
      expect(response.status).to eq 201
      parsed = JSON.parse(response.body)
      expect(parsed['description']).to eq 'A goal'

      goal_id = parsed['id']

      sign_in @manager
      post "/users/#{@employee.id}/goals/#{goal_id}/approve", nil, request_headers
      expect(response.status).to eq 200
      parsed = JSON.parse(response.body)
      expect(parsed['state']).to eq 'approved'

      sign_in @employee
      goal_params = {
        goal: {
          self_evaluation: 'I did well.'
        }
      }
      put "/users/#{@employee.id}/goals/#{goal_id}", goal_params.to_json, request_headers
      expect(response.status).to eq 200
      parsed = JSON.parse(response.body)
      expect(parsed['state']).to eq 'self_eval_completed'

      sign_in @manager
      goal_params = {
        goal: {
          manager_evaluation: 'You did terrible.'
        }
      }
      put "/users/#{@employee.id}/goals/#{goal_id}", goal_params.to_json, request_headers
      expect(response.status).to eq 200
      parsed = JSON.parse(response.body)
      expect(parsed['state']).to eq 'manager_eval'

      sign_in @employee
      post "/users/#{@employee.id}/goals/#{goal_id}/sign_off", nil, request_headers
      expect(response.status).to eq 200
      parsed = JSON.parse(response.body)
      expect(parsed['state']).to eq 'completed'
    end
  end
end
