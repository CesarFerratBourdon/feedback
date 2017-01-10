require 'rails_helper'
require 'shared_contexts'

describe 'Team' do
  include_context 'api request authentication helper methods'
  include_context 'api request global before and after hooks'

  before :all do
    @manager = FactoryGirl.create :manager

    (1..10).each do
      FactoryGirl.create :user, manager_id: @manager.id
    end
  end

  describe 'GET /team' do
    it 'lists users on a team' do
      request_headers = {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }
      sign_in @manager
      get '/team', nil, request_headers
      expect(response.status).to eq 200
      parsed = JSON.parse(response.body)
      expect(parsed['members'].count).to eq 10
    end
  end
end
