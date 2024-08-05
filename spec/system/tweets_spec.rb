require 'rails_helper'

RSpec.describe "Tweets", type: :system do
  before do
    driven_by(:rack_test)
    @user = FactoryBot.build (:user)
    @user.confirm
    sign_in @user
  end

  describe 'tweet' do
    it 'success to tweet' do
      visit root_path
      fill_in 'tweet[content]', with: 'test'
      click_button 'ツイートする'
      expect(page).to have_content('投稿しました')
    end

    it 'fail to tweet' do
      visit root_path
      fill_in 'tweet[content]', with: 'test' * 35 + 't'
      click_button 'ツイートする'
      expect(page).to have_content('投稿に失敗しました')
    end
  end
end
