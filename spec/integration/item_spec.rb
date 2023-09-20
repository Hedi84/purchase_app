require 'swagger_helper'

describe 'Item API' do

  path '/api/v1/items' do

    post 'Creates a item' do
      tags 'Item'
      consumes 'application/json', 'application/xml'
      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: {
          item_option_id: { type: :integer },
          purchase_id: { type: :integer }
        },
        required: [ 'email' ]
      }

      response '201', 'item created' do
        let(:item) { { item_option_id: 1, purchase_id: 3 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:item) { { item_option_id: 1 } }
        run_test!
      end
    end
  end

  path '/api/v1/items/{id}' do

    get 'Retrieves a item' do
      tags 'Item'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'name found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            item_option_id: { type: :integer },
            purchase_id: { type: :integer }
          },
          required: [ 'id', 'item_option_id', 'purchase_id' ]

        let(:id) { Item.create(item_option_id: 1, purchase_id: 7 ).id }
        run_test!
      end

      response '404', 'item not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end