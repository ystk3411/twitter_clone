# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'sign up' do 
    it 'success to sign up' do 
      post user_registration_path, params: {user: {email: "yoshitaka.sample@sample.com",
                                                   password: "password",
                                                   telephone_number: "0127117117",
                                                   birth_day: "2024-05-05",
                                                   name: "yoshitaka"}}
      expect(response).to have_http_status(303)
    end

    it 'fail to sign up' do 
      post user_registration_path, params: {user: {email: "yoshitaka.sample.com",
                                                   password: "password",
                                                   telephone_number: "0127117117",
                                                   birth_day: "2024-05-05",
                                                   name: "yoshitaka"}}
      expect(response).to have_http_status(303)
    end
  end

  describe 'log in' do
    it 'success to log in' do 
      user = User.create(email: "yoshitaka.sample@sample.com",
                    password: "password",
                    telephone_number: "0127117117",
                    birth_day: Date.new(2020, 9, 5),
                    name: "yoshitaka")
      user.confirm
      sign_in user
      get bookmarks_path
      expect(response).to have_http_status(200)
    end

    it 'fail to log in' do
      user = User.create(email: "yoshitaka.samplesample.com",
                    password: "password",
                    telephone_number: "0127117117",
                    birth_day: Date.new(2020, 9, 5),
                    name: "yoshitaka")
      user.confirm
      sign_in user
      get bookmarks_path
      expect(response).to redirect_to root_path
    end
  end
end
