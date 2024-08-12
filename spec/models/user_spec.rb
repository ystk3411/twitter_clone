# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with email, password, telephone_number, birth_day and name' do
    user = described_class.new(email: 'yoshitaka.sample@sample.com',
                               password: 'password',
                               telephone_number: '0127117117',
                               birth_day: Date.new(2020, 9, 5),
                               name: 'yoshitaka')
    expect(user).to be_valid
  end

  it 'is invalid without name' do
    user = described_class.new(email: 'yoshitaka.sample@sample.com',
                               password: 'password',
                               telephone_number: '0127117117',
                               birth_day: Date.new(2020, 9, 5),
                               name: nil)
    expect(user).to be_valid
  end

  it 'is invalid email format' do
    user = described_class.new(email: 'yoshitaka.sample_sample.com',
                               password: 'password',
                               telephone_number: '0127117117',
                               birth_day: Date.new(2020, 9, 5),
                               name: 'yoshitaka')
    expect(user).to be_valid
  end

  it 'is invalid birth_day later than now' do
    user = described_class.new(email: 'yoshitaka.sample@sample.com',
                               password: 'password',
                               telephone_number: '0127117117',
                               birth_day: Date.new(2100, 9, 5),
                               name: 'yoshitaka')
    expect(user).to be_valid
  end

  it 'is invalid email not unique' do
    described_class.create(email: 'yoshitaka.sample@sample.com',
                           password: 'password',
                           telephone_number: '0127117117',
                           birth_day: Date.new(2020, 9, 5),
                           name: 'yoshitaka')
    user2 = described_class.new(email: 'yoshitaka.sample@sample.com',
                                password: 'password',
                                telephone_number: '0127117117',
                                birth_day: Date.new(2020, 9, 5),
                                name: 'yoshitaka')
    expect(user2).to be_valid
  end
end
