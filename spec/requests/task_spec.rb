# frozen_string_literal: true

# comment
require 'rails_helper'

RSpec.describe 'task_controller', type: :request do
  describe 'GET /input' do
    it 'returns http success' do
      get '/'
      expect(response).to have_http_status(:success)
    end

    it 'returns render_template' do
      get '/'
      expect(response).to render_template 'input'
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/task/show', params: { number: '2 2 3 2 3 0 1 2 3 4 5 5 6' }
      expect(response).to have_http_status(:success)
    end

    it 'returns http redirect' do
      get '/task/show', params: { number: 'f' }
      expect(response).to have_http_status(:redirect)
    end

    it 'returns render_template' do
      get '/task/show', params: { number: '2 4 10 2 3 -1 1 2 3 4 5 5 6' }
      expect(response).to render_template 'show'
    end
  end
end

RSpec.describe 'task_controller_func', type: :request do
  describe 'edit()' do
    it 'check return' do
      expect(TaskController.new.send(:edit, [1, 2, 3, 0, -1, 23, 2])).to eq([[1, 2, 3], [-1, 23]])
    end
  end
  describe 'max()' do
    it 'check return' do
      expect(TaskController.new.send(:max, [[1, 2, 3, 5], [0, 1, 2], [3, 4]])).to eq('1 2 3 5')
    end
  end
end
