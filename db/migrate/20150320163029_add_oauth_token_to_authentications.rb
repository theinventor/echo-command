class AddOauthTokenToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :oauth_token, :string
  end
end
