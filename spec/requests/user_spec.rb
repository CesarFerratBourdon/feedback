describe 'User' do
  describe 'POST /users/role/admin' do
    it 'creates an admin user' do
      user_params = {
        user: {
          first_name: 'Jon',
          last_name: 'Stewart',
          email: 'js@js.com',
          password: 'muffins1',
          password_confirmation: 'muffins1',
          job_title: 'HR Rep',
          username: 'jstewart',
          team_size: 6
        },
        company: {
          'Company': 'MeowCo'
        }
      }

      request_headers = {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }

      post '/users/role/admin', user_params.to_json, request_headers

      expect(response.status).to eq 201

      parsed = JSON.parse(response.body)

      expect(parsed['success']).to eq true
    end
  end

  describe 'POST /users/role/employee' do
    it 'creates an employee user' do
      FactoryGirl.create :team
      FactoryGirl.create :admin

      user_params = {
        user: {
          first_name: 'Bob',
          last_name: 'Smith',
          email: 'bsmith@js.com',
          password: 'muffins1',
          password_confirmation: 'muffins1',
          job_title: 'HR Rep',
          username: 'bsmith',
          managers_email: 'js@js.com'
        }
      }

      request_headers = {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }

      post '/users/role/employee', user_params.to_json, request_headers

      expect(response.status).to eq 201

      parsed = JSON.parse(response.body)

      expect(parsed['success']).to eq true
    end
  end

  describe 'POST /users/role/manager' do
    it 'creates an manager user with an invite' do
      FactoryGirl.create :team
      FactoryGirl.create :admin
      FactoryGirl.create :invite

      user_params = {
        user: {
          first_name: 'Bob',
          last_name: 'Smith',
          email: 'bsmith@js.com',
          password: 'muffins1',
          password_confirmation: 'muffins1',
          job_title: 'HR Rep',
          username: 'bsmith',
          managers_email: 'js@js.com',
          invite_id: 'a3db9a59-594c-4bd1-917a-7766cbca09d7'
        }
      }

      request_headers = {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }

      post '/users/role/manager', user_params.to_json, request_headers

      expect(response.status).to eq 201

      parsed = JSON.parse(response.body)

      expect(parsed['success']).to eq true
    end
  end

  describe 'POST /users/sign_in' do
    it 'signs in and out' do
      FactoryGirl.create :admin

      user_params = {
        user: {
          email: 'js@js.com',
          password: 'muffins1'
        }
      }

      request_headers = {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }

      post '/users/sign_in', user_params.to_json, request_headers

      expect(response.status).to eq 201

      parsed = JSON.parse(response.body)

      expect(parsed['email']).to eq 'js@js.com'

      # sign out
      delete '/users/sign_out', nil, request_headers

      expect(response.status).to eq 204
    end
  end
end
