
# spec/integration/pets_spec.rb
require 'swagger_helper'

describe 'ItemOptions API' do

  path '/api/v1/item_options' do

    post 'Creates a item_option' do
      tags 'ItemOption'
      consumes 'application/json', 'application/xml'
      parameter name: :item_option, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          allocation: { type: :integer }
        },
        required: [ 'name', 'allocation', 'description' ]
      }

      response '201', 'item_option created' do
        let(:item_option) { { name: 'IPhone', allocation: 200, description: 'new IPhone'} }
        run_test!
      end

      response '422', 'invalid request' do
        let(:item_option) { { name: 'IPhone' } }
        run_test!
      end
    end
  end

  path '/api/v1/item_options/{id}' do

    get 'Retrieves a item_option' do
      tags 'ItemOption'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'name found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            name: { type: :string },
            description: { type: :string },
            allocation: { type: :integer }
          },
          required: [ 'id', 'name', 'allocation' ]

        let(:id) { ItemOption.create(name: 'External hard drive', allocation: 30, description: 'External hard drive to backup').id }
        run_test!
      end

      response '404', 'item_option not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end