# frozen_string_literal: true

class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: %i[github]
  validates :uid, uniqueness: { scope: :provider }, if: -> { uid.present? }
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX }
  validates :birth_day, comparison: { less_than: Time.zone.now }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :trackable, :omniauthable, omniauth_providers: %i[github]
  has_many :tweets, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy,
                                  inverse_of: :follower
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy,
                                   inverse_of: :followed
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :likes, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :read_counts, dependent: :destroy
  has_many :book_marks, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_one_attached :header
  has_one_attached :profile
  has_many :active_notifications, class_name: 'Notification',
                                  foreign_key: 'visitor_id',
                                  dependent: :destroy,
                                  inverse_of: :visitor
  has_many :passive_notifications, class_name: 'Notification',
                                   foreign_key: 'visited_id',
                                   dependent: :destroy,
                                   inverse_of: :visited

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.telephone_number = '00000000000'.to_i
      user.birth_day = '2024-04-14'

      if user.persisted? || auth.provider == 'github'
        user.skip_confirmation! if auth.provider == 'github'
        user.save
      end
    end
  end

  def self.create_unique_string
    SecureRandom.uuid
  end
end
