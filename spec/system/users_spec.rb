require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'sign up' do
    it 'success to sign up' do
      visit root_url
      click_link '新規登録'
      fill_in 'user[name]', with: 'yoshitaka'
      fill_in 'user[email]', with: 'sample@sample.com'
      select '2000', from: 'user_birth_day_1i'
      select '1', from: 'user_birth_day_2i'
      select '1', from: 'user_birth_day_3i'
      fill_in 'user[telephone_number]', with: 0120117117
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button '新規登録'
      expect(page).to have_current_path(root_path)
    end

    it 'fail to sign up' do
      visit root_url
      click_link '新規登録'
      fill_in 'user[name]', with: 'yoshitaka'
      fill_in 'user[email]', with: 'samplesample.com'
      select '2000', from: 'user_birth_day_1i'
      select '1', from: 'user_birth_day_2i'
      select '1', from: 'user_birth_day_3i'
      fill_in 'user[telephone_number]', with: 0120117117
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button '新規登録'
      expect(page).to have_content('エラーが発生したため ユーザー は保存されませんでした。')
    end
  end

  describe 'log in' do
    before do
      @user = FactoryBot.build (:user)
      @user.confirm
    end

    it 'success to log in' do
      visit '/users/sign_in'
      fill_in 'user[email]', with: 'yoshitaka.sample@sample.com'
      fill_in 'user[password]', with: 'password'
      click_button 'ログイン'
      expect(page).to have_content('ログインしました')
    end

    it 'fail to log in' do
      visit '/users/sign_in'
      fill_in 'user[email]', with: 'yoshitaka.sample@sample.com'
      fill_in 'user[password]', with: 'passwor'
      click_button 'ログイン'
      expect(page).to have_content('Eメールまたはパスワードが違います。')
    end
  end
end
