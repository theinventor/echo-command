class AddOauthCodeToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :oauth_code, :string
  end
end
