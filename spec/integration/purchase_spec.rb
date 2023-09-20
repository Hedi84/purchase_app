require 'swagger_helper'

describe 'Purchase API' do

  path '/api/v1/purchases' do

    post 'Creates a purchase' do
      tags 'Purchase'
      consumes 'application/json', 'application/xml'
      parameter name: :purchase, in: :body, schema: {
        type: :object,
        properties: {
          item_id: { type: :integer },
          user_id: { type: :integer }
        },
        required: [ 'email' ]
      }

      response '201', 'purchase created' do
        let(:purchase) { { user_id: 1, item_id: 6 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:purchase) { { user_id: 3 } }
        run_test!
      end
    end
  end

  path '/api/v1/purchases/{id}' do

    get 'Retrieves a purchase' do
      tags 'Purchase'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'name found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            item_id: { type: :integer },
            user_id: { type: :integer }
          },
          required: [ 'id', 'email' ]

        let(:id) { Purchase.create(user_id: 8, item_id: 5).id }
        run_test!
      end

      response '404', 'purchase not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end