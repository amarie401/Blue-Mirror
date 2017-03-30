# :nodoc
class User < ApplicationRecord
  include Seed

  MY_SALT = ENV['SALT']

  # before_create :set_hashed_id
  #
  # def set_hashed_id
  #   self.uid = User.get_hash uid
  # end

  def self.get_hash(uid)
    Digest::SHA1.hexdigest("--#{MY_SALT}--#{uid}--")
  end

  def self.from_omniauth(auth)
    hashed_id = get_hash auth.uid
    where(provider: auth.provider, uid: hashed_id).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = hashed_id
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!

      seed_todos(user.id) if user.created_at == user.updated_at
    end
  end
end
