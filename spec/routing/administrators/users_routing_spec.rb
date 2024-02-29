require 'rails_helper'

RSpec.describe Administrator::UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/administrator/users').to route_to('administrator/users#index')
    end

    it 'routes to #show' do
      expect(get: '/administrator/users/1').to route_to('administrator/users#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/administrator/users/1/edit').to route_to('administrator/users#edit', id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/administrator/users/1').to route_to('administrator/users#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/administrator/users/1').to route_to('administrator/users#update', id: '1')
    end

    it 'routes to #new' do
      expect(get: '/administrator/users/new').to route_to('administrator/users#new')
    end

    it 'routes to #create' do
      expect(post: '/administrator/users').to route_to('administrator/users#create')
    end

    it 'routes to #destroy' do
      expect(delete: '/administrator/users/1').to route_to('administrator/users#destroy', id: '1')
    end
  end
end
