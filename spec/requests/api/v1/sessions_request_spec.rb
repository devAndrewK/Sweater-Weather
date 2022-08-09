require 'rails_helper'

RSpec.describe '/users', :vcr do
  describe '#create' do
    describe 'happy path' do
      it 'returns a user when authenticated as valid user' do
        create_body = {
          "email": 'test@gmail.com',
          "password": 'testt',
          "password_confirmation": 'testt'
        }
        post '/api/v1/users', params: create_body

        login_body = {
          "email": 'test@gmail.com',
          "password": 'testt'
        }
        post '/api/v1/sessions', params: login_body

        expect(response).to be_successful

        parsed_body = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_body).to have_key(:data)
        expect(parsed_body[:data]).to be_a Hash

        user = parsed_body[:data]

        expect(user).to have_key :id
        expect(user[:id]).to be_a String
        expect(user).to have_key :type
        expect(user[:type]).to eq('user')

        expect(user).to have_key :attributes

        expect(user[:attributes]).to have_key :email
        expect(user[:attributes][:email]).to be_a String

        expect(user[:attributes]).to have_key :api_key
        expect(user[:attributes][:api_key]).to be_a String
      end
    end

    describe 'sad path' do
        it 'returns unsuccessful when invalid credentials are used' do
          create_body = {
            "email": 'test@gmail.com',
            "password": 'testt',
            "password_confirmation": 'testt'
          }
          post '/api/v1/users', params: create_body

          login_body = {
            "email": 'test@gmail.com',
            "password": 't'
          }
          post '/api/v1/sessions', params: login_body

          expect(response).to_not be_successful

          parsed_body = JSON.parse(response.body, symbolize_names: true)

          expect(parsed_body).to have_key(:error)
          expect(parsed_body[:error]).to eq 'Invalid Credentials'
        end
    end
  end
end