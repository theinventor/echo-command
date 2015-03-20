class Authentication < ActiveRecord::Base
  belongs_to :user
  has_many :echo_users


  def self.find_or_create_from_auth_hash(auth_hash)
    auth = find_by(uid: auth_hash[:uid]) || new(uid: auth_hash[:uid], nickname: auth_hash[:info][:nickname], name: auth_hash[:info][:name] )
    if auth.new_record?
      new_pass = SecureRandom.hex
      user = User.create(email: "#{auth_hash[:uid]}@echocommand.com", password: new_pass, password_confirmation: new_pass)
      auth.user_id = user.id
      auth.save
    end
    auth
  end

  def echo_user
    echo_users.first
  end

end
