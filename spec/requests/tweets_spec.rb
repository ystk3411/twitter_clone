# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tweets', type: :request do
  describe 'tweet' do
    before do
      user = FactoryBot.build(:user)
      user.confirm
      sign_in user
    end

    it 'success to tweet' do
      post tweets_path, params: { tweet: { content: 'test' * 35 } }
      expect(response).to have_http_status(:found)
    end

    it 'fail to tweet' do
      post tweets_path, params: { tweet: { content: 'test' * 36 } }
      expect(flash[:error]).to eq('投稿に失敗しました')
    end
  end
end
