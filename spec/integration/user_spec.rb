require 'swagger_helper'

describe 'User API' do

  path '/api/v1/users' do

    post 'Creates a user' do
      tags 'User'
      consumes 'application/json', 'application/xml'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string }
        },
        required: [ 'email' ]
      }

      response '201', 'user created' do
        let(:user) { { email: 'email@mail.com'} }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { {  } }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do

    get 'Retrieves a user' do
      tags 'User'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'name found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            email: { type: :string }
          },
          required: [ 'id', 'email' ]

        let(:id) { User.create(email: 'mail@email.com').id }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end